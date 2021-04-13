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

    @Published var nickname = ""
    @Published var dateOfBirth = Date()
    @Published var languages = [String]()
    @Published var yearsOfExperience = 0
    @Published var hobbies = ""
    @Published var accreditations = [String]()
    @Published var area: Area?
    @Published var biography = ""
    @Published var trails = [Trail]()
    @Published var days = [Days]()

    func submitDetails() {
        guard let area = area else {
            fatalError("Area should not be nil as of submission")
        }
        guard let userId = UUID(uuidString: userState.userId) else {
            fatalError("User should have been logged in by now")
        }

        let details = GuideOnboardingDetails(userId: userId,
                                             nickname: nickname,
                                             dateOfBirth: dateOfBirth,
                                             languages: languages,
                                             yearsOfExperience: yearsOfExperience,
                                             hobbies: hobbies,
                                             accreditations: accreditations,
                                             area: area,
                                             biography: biography,
                                             trails: trails,
                                             daysAvailable: days)
        interactor.submitGuideDetails(details: details)
    }

    func showSubmissionResult(success: Bool) {
        
    }

}
