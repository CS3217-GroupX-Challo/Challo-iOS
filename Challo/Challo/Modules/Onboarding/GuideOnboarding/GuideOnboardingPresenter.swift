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

    @Published var nickname = ""
    @Published var dateOfBirth = Date()
    @Published var languages = [String]()
    @Published var yearsOfExperience = 0
    @Published var hobbies = ""
    @Published var accreditations = [String]()
    @Published var area: Area?
    @Published var biography = ""
    @Published var trails = ""
    @Published var days = Set<Days>()

}
