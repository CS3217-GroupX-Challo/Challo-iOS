protocol LoginService {
    var loginDelegate: LoginDelegate? { get set }
    func login()
}
