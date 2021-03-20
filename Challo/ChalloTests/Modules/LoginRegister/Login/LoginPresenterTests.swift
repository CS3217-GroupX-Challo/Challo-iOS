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

    private var presenter: LoginPresenterMock!
    private var interactor: LoginInteractorMock!
    private var router: LoginRouterMock!

    override func setUp() {
        super.setUp()
        let presenter = LoginPresenterMock()
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
        XCTAssertTrue(interactor.loginWasCalled)
    }

    func testShowAlert_showAlertVariableToggled() {
        presenter.showLoginFailureAlert()
        XCTAssertTrue(presenter.isShowingLoginFailureAlert)
    }

    func testGetRegistrationPage_routerReturnsPage() {
        _ = presenter.getRegistrationPage()
        XCTAssertTrue(router.routerWasCalled)
    }
}

private class LoginPresenterMock: LoginPresenter {

    var interactor: LoginInteractor!
    
    var router: LoginRouter?
    
    var email = "email"
    
    var password = "password"
    
    var isShowingLoginFailureAlert = false
}

private class LoginInteractorMock: LoginInteractor {

    var loginWasCalled = false
    weak var presenter: LoginPresenter!
    
    func defaultLogin(email: String, password: String) {
        loginWasCalled = true
    }
}

private class LoginRouterMock: LoginRouter {

    var routerWasCalled = false

    func getRegistrationPage() -> AnyView {
        routerWasCalled = true
        return AnyView(Text("test"))
    }
}
