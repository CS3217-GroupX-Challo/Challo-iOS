//
//  GuideOnboardingInteractor.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

class GuideOnboardingInteractor: InteractorProtocol {

    weak var presenter: GuideOnboardingPresenter!

    let userState: UserStateProtocol
    let trailRepository: TrailRepositoryProtocol
    let userParser: UserAPIParser
    let certificateManager: CertificateManager
    let onboardingAPI: GuideOnboardingAPI

    internal init(userState: UserStateProtocol,
                  trailRepository: TrailRepositoryProtocol,
                  userParser: UserAPIParser,
                  certificateManager: CertificateManager,
                  onboardingAPI: GuideOnboardingAPI) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.userParser = userParser
        self.onboardingAPI = onboardingAPI
        self.certificateManager = certificateManager
    }

    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.userParser = UserAPIParser(userState: userState)
        self.certificateManager = CertificateManager(userState: userState)
        self.onboardingAPI = GuideOnboardingAPI(userState: userState, guideAPI: guideAPI)
    }

    func submitGuideDetails(details: GuideOnboardingDetails) {
        onboardingAPI.updateGuideParticulars(details: details) { [weak self] response, error in
            guard error == nil else {
                self?.presenter.showSubmissionResult(success: false)
                return
            }
            let certificate = self?.userParser.parseUser(apiResponse: response)
            guard let certificateUnwrapped = certificate else {
                self?.presenter.showSubmissionResult(success: false)
                return
            }
            self?.certificateManager.storeCertificate(certificate: certificateUnwrapped)
            self?.presenter.showSubmissionResult(success: true)
        }
    }

    func fetchTrailsAndAreas() {
        trailRepository.fetchTrailsAndRefresh { [weak self] trails in
            self?.presenter.didFetchTrailsAndAreaData(trails: trails)
        }
    }
    
}
