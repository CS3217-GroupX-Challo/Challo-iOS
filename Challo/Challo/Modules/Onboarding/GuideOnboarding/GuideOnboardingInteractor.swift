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
    let onboardingAPI: GuideOnboardingAPI
    let guideAPI: GuideAPIProtocol

    internal init(userState: UserStateProtocol,
                  trailRepository: TrailRepositoryProtocol,
                  userParser: UserAPIParser,
                  onboardingAPI: GuideOnboardingAPI,
                  guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.userParser = userParser
        self.onboardingAPI = onboardingAPI
        self.guideAPI = guideAPI
    }

    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.userParser = UserAPIParser(userState: userState)
        self.onboardingAPI = GuideOnboardingAPI(userState: userState, guideAPI: guideAPI)
        self.guideAPI = guideAPI
    }

    func submitGuideDetails(details: GuideOnboardingDetails) {
        onboardingAPI.updateGuideParticulars(details: details) { [weak self] _, error in
            guard error == nil else {
                self?.presenter.showSubmissionResult(success: false)
                return
            }
            self?.presenter.showSubmissionResult(success: true)
        }
    }

    func fetchTrailsAndAreas() {
        trailRepository.fetchTrailsAndRefresh { [weak self] trails in
            self?.presenter.didFetchTrailsAndAreaData(trails: trails)
        }
    }
    
}
