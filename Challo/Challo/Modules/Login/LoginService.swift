protocol LoginService {
    var loginDelegate: LoginDelegate? { get set }
    func login()
}

struct LoginResponse {
    var success: Bool
    var email: String?
    var name: String?
    var token: String?
    var userId: String?
}
