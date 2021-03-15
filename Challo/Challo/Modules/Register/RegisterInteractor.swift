import Combine

class RegisterInteractor: InteractorProtocol {

    weak var presenter: RegisterPresenter!

    func register(details: RegistrationDetails) {
        // interact with backend here
        print("registered with details: \(details)")
    }
}
