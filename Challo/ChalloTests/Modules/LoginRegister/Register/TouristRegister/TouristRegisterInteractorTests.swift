//
//  TouristRegisterInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class TouristRegisterInteractorTests: XCTestCase {

    private var interactor: TouristRegisterInteractor!
    private var presenter: TouristRegisterPresenter!
    private var registerAPI: MockRegisterAPI!
    private var mockCertificateManager: MockCertificateManager!
    private var userState: MockUserState!

    override func setUp() {
        super.setUp()
        self.userState = MockUserState()
        self.mockCertificateManager = MockCertificateManager(state: userState)
        self.registerAPI = MockRegisterAPI()
        self.interactor = TouristRegisterInteractor(registerAPI: self.registerAPI,
                                                    certificateManager: mockCertificateManager)
        self.presenter = TouristRegisterPresenter()
        self.interactor.presenter = self.presenter
        self.interactor.certificateManager = mockCertificateManager
    }
    
    func testRegister_success_userStateLoggedIn() {
        interactor.register(details: registerAPI.details)
        XCTAssertTrue(userState.loggedIn)
    }

    func testRegister_success_userDetailsStored() {
        interactor.register(details: registerAPI.details)
        XCTAssertEqual(registerAPI.certificate.name, userState.name)
        XCTAssertEqual(registerAPI.certificate.email, userState.email)
        XCTAssertEqual(registerAPI.certificate.token, userState.token)
        XCTAssertEqual(registerAPI.certificate.userId, userState.userId)
    }

    func testRegister_failure_userStateNotLoggedIn() {
        registerAPI.shouldSucceed = false
        interactor.register(details: registerAPI.details)
        XCTAssertFalse(userState.loggedIn)
    }
}
