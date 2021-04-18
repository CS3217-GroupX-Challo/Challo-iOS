//
//  GuideOnboardingPresenter.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation
import SwiftUI

class GuideOnboardingPresenter: PresenterProtocol {

    var interactor: GuideOnboardingInteractor!
    var router: GuideOnboardingRouter?

    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    @Published var loaded = false

    @Published var nickname = ""
    @Published var dateOfBirth = Date()
    @Published var languages = Set<Languages>()
    @Published var yearsOfExperience = "0" {
        didSet {
            let filtered = yearsOfExperience.filter { $0.isNumber }
            
            if yearsOfExperience != filtered {
                yearsOfExperience = filtered
            }
        }
    }
    @Published var hobbies = ""
    @Published var accreditations = [String]()
    @Published var biography = ""
    @Published var daysAvailable = Set<Days>()

    @Published var trails = [Trail]()
    @Published var chosenTrails = Set<HashableTrailOption>()

    @Published var isShowingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    var isOnboardSuccess = false

    var allNecessaryFieldsFilled: Bool {
        !nickname.isEmpty
            && !languages.isEmpty
            && !yearsOfExperience.isEmpty
            && !hobbies.isEmpty
            && !biography.isEmpty
            && !daysAvailable.isEmpty
            && !chosenTrails.isEmpty
    }

    func submitDetails() {
        guard allNecessaryFieldsFilled else {
            showSubmissionResult(success: false)
            return
        }

        guard let userId = UUID(uuidString: userState.userId) else {
            fatalError("User should have been logged in by now")
        }
        guard let yearsOfExperience = Int(yearsOfExperience) else {
            fatalError("Only numerical answers should have been accepted")
        }
        let chosenTrails = self.chosenTrails.compactMap { choice in
            trails.first(where: { $0.trailId == choice.id })
        }

        let details = GuideOnboardingDetails(userId: userId,
                                             nickname: nickname,
                                             dateOfBirth: dateOfBirth,
                                             languages: Array(languages),
                                             yearsOfExperience: yearsOfExperience,
                                             hobbies: hobbies,
                                             accreditations: accreditations,
                                             biography: biography,
                                             trails: chosenTrails,
                                             daysAvailable: Array(daysAvailable))
        interactor.submitGuideDetails(details: details)
    }

    func loadTrailAndAreaData() {
        interactor.fetchTrailsAndAreas()
    }

    func didFetchTrailsAndAreaData(trails: [Trail], area: [Area] = []) {
        loaded = true
        self.trails = trails
    }

    func showSubmissionResult(success: Bool) {
        isShowingAlert = true
        isOnboardSuccess = success
        if success {
            alertTitle = "Success!"
            alertMessage = "Details successfully saved, welcome aboard!"
        } else {
            alertTitle = "Uh oh!"
            alertMessage = "Something went wrong, have you filled all of the details?"
        }
    }

}
