//
//  TouristLoginInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class TouristLoginInteractorTests: XCTestCase {

    private var interactor: TouristLoginInteractor!
    private var presenter: TouristLoginPresenter!
    private var loginAPI: MockLoginAPI!
    private var mockCertificateManager: MockCertificateManager!
    private var userState: MockUserState!

    override func setUp() {
        super.setUp()
        self.userState = MockUserState()
        self.mockCertificateManager = MockCertificateManager(state: userState)
        self.loginAPI = MockLoginAPI()
        self.interactor = TouristLoginInteractor(loginAPI: self.loginAPI, certificateManager: mockCertificateManager)
        self.presenter = TouristLoginPresenter()
        self.interactor.presenter = self.presenter
        self.interactor.certificateManager = mockCertificateManager
    }
    
    func testLogin_success_userStateLoggedIn() {
        interactor.defaultLogin(email: loginAPI.testEmail, password: loginAPI.testPassword)
        XCTAssertTrue(userState.loggedIn)
    }

    func testLogin_success_userDetailsStored() {
        interactor.defaultLogin(email: loginAPI.testEmail, password: loginAPI.testPassword)
        XCTAssertEqual(loginAPI.certificate.name, userState.name)
        XCTAssertEqual(loginAPI.certificate.email, userState.email)
        XCTAssertEqual(loginAPI.certificate.token, userState.token)
        XCTAssertEqual(loginAPI.certificate.userId, userState.userId)
    }

    func testRegister_failure_userStateNotLoggedIn() {
        interactor.defaultLogin(email: loginAPI.wrongEmail, password: loginAPI.wrongPassword)
        XCTAssertFalse(userState.loggedIn)
    }
}
