//
//  MainContainerInteractor.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

class MainContainerInteractor: InteractorProtocol {

    weak var presenter: MainContainerPresenter!
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func checkIfUserLoggedIn() -> Bool {
        userState.loggedIn
    }

    var guideCompletedOnboarding: Bool {
        guard let user = userState.user as? Guide else {
            return false
        }
        guard let languages = user.languages,
              user.yearsOfExperience != nil,
              let hobbies = user.hobbies,
              let biography = user.biography,
              !user.daysAvailable.isEmpty,
              !user.trails.isEmpty else {
            return false
        }
        return !languages.isEmpty && !hobbies.isEmpty && !biography.isEmpty
    }
}
