protocol LoginDelegate: AnyObject {
    func loginProcessCompleted(loginResponse: LoginResponse)
}
