import Combine

class RegisterInteractor: ObservableObject {

    func register(details: RegistrationDetails) {
        // interact with backend here
        print("registered with details: \(details)")
    }
}
