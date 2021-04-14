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
    let areaRepository: AreaRepositoryProtocol
    let trailRepository: TrailRepositoryProtocol
    let onboardingAPI: GuideOnboardingAPI

    internal init(userState: UserStateProtocol,
                  areaRepository: AreaRepositoryProtocol,
                  trailRepository: TrailRepositoryProtocol,
                  onboardingAPI: GuideOnboardingAPI) {
        self.userState = userState
        self.areaRepository = areaRepository
        self.trailRepository = trailRepository
        self.onboardingAPI = onboardingAPI
    }

    init(userState: UserStateProtocol,
         areaRepository: AreaRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.areaRepository = areaRepository
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

    private func updateTrails(details: GuideOnboardingDetails) {
        guard let guideUUID = UUID(uuidString: userState.userId) else {
            fatalError("Onboarding should only be done for a logged in guide")
        }
        trailRepository.fetchTrailsAndRefresh { fetchedTrails in
            var trailsToUpdate = fetchedTrails.filter {
                details.trails.contains($0) && !$0.guideIds.contains(guideUUID)
            }
            for index in 0..<trailsToUpdate.count {
                trailsToUpdate[index].guideIds.append(guideUUID)
            }
        }

    }

    func fetchTrailsAndAreas() {
        /*
        areaRepository.fetchAreasAndRefresh { [weak self] areas in
            self?.areas = areas
        }
         */
        trailRepository.fetchTrailsAndRefresh { [weak self] trails in
            self?.presenter.didFetchTrailsAndAreaData(trails: trails, area: [])
        }
    }
    
}
