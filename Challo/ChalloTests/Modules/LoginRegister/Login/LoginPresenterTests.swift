//
//  LoginPresenterTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class LoginPresenterTests: XCTestCase {

    private var presenter: LoginPresenterImplementation!
    private var interactor: LoginInteractorMock!
    private var router: LoginRouterMock!

    override func setUp() {
        super.setUp()
        let presenter = LoginPresenterImplementation()
        let interactor = LoginInteractorMock()
        let router = LoginRouterMock()

        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        self.presenter = presenter
        self.interactor = interactor
        self.router = router
    }

    func testLogin_interactorLoginMethodCalled() {
        presenter.login()
        XCTAssertTrue(interactor.loginWasCalled, "Interactor not called")
    }

    func testShowAlert_showAlertVariableToggled() {
        presenter.showLoginFailureAlert()
        XCTAssertTrue(presenter.isShowingLoginFailureAlert, "Login alert variable not toggled")
    }

    func testGetRegistrationPage_routerReturnsPage() {
        _ = presenter.getRegistrationPage()
        XCTAssertTrue(router.routerWasCalled, "Router not called")
    }
}

class LoginPresenterImplementation: LoginPresenter {

    var interactor: LoginInteractorMock!
    
    var router: LoginRouterMock?
    
    var email = "email"
    
    var password = "password"
    
    var isShowingLoginFailureAlert = false
}

class LoginInteractorMock: LoginInteractor {

    var certificateManager: CertificateManager = MockCertificateManager(state: MockUserState())
    var loginWasCalled = false
    weak var presenter: LoginPresenterImplementation!
    
    func defaultLogin(email: String, password: String) {
        loginWasCalled = true
    }
}

class LoginRouterMock: LoginRouter {
    var presenter: LoginPresenterImplementation!
    
    var routerWasCalled = false

    func getRegistrationPage() -> AnyView {
        routerWasCalled = true
        return AnyView(Text("test"))
    }
}
