import SwiftUI

class RegisterPresenter: ObservableObject {

    var interactor: RegisterInteractor
    @Published var userName = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""

    init(interactor: RegisterInteractor) {
        self.interactor = interactor
    }
}
