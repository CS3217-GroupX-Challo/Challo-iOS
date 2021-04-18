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
    let onboardingAPI: GuideOnboardingAPI

    internal init(userState: UserStateProtocol,
                  trailRepository: TrailRepositoryProtocol,
                  onboardingAPI: GuideOnboardingAPI) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.onboardingAPI = onboardingAPI
    }

    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.onboardingAPI = GuideOnboardingAPI(userState: userState)
    }

    func submitGuideDetails(details: GuideOnboardingDetails) {
        onboardingAPI.updateGuideParticulars(details: details) { [weak self] error in
            if error == nil {
                self?.presenter.showSubmissionResult(success: true)
            } else {
                self?.presenter.showSubmissionResult(success: false)
            }
        }
    }

    func fetchTrailsAndAreas() {
        trailRepository.fetchTrailsAndRefresh { [weak self] trails in
            self?.presenter.didFetchTrailsAndAreaData(trails: trails)
        }
    }
    
}
