protocol LoginDelegate: AnyObject {
    func loginProcessCompleted(response: UserAPIResponse)
}
