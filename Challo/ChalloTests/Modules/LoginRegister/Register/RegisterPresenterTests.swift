//
//  RegisterPresenterTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class RegisterPresenterTests: XCTestCase {

    private var presenter: RegisterPresenterImplementation!
    private var interactor: RegisterInteractorMock!

    override func setUp() {
        super.setUp()
        let presenter = RegisterPresenterImplementation()
        let interactor = RegisterInteractorMock()

        presenter.interactor = interactor
        interactor.presenter = presenter

        self.presenter = presenter
        self.interactor = interactor
    }

    func testSubmitRegistration_implementorRegisterCalled() {
        presenter.email = "test@email.com"
        presenter.name = "tester"
        presenter.phone = "12345678"
        presenter.password = "abc123"
        presenter.submitRegistration()
        XCTAssertTrue(interactor.registerWasCalled, "Interactor not called")
    }

    func testShowFailureAlert_showAlertVariableToggled() {
        presenter.showRegisterFailureAlert()
        XCTAssertTrue(presenter.isShowingRegisterAlert, "Register alert variable not toggled")
    }

    func testShowSuccessAlert_showAlertVariableToggled() {
        presenter.showRegisterSuccessAlert()
        XCTAssertTrue(presenter.isShowingRegisterAlert, "Register alert variable not toggled")
    }
}

class RegisterPresenterImplementation: RegisterPresenter {

    var interactor: RegisterInteractorMock!
    
    var router: RegisterRouterMock?
    
    var name = ""
    
    var phone = ""
    
    var email = ""
    
    var password = ""
    
    var isShowingRegisterAlert = false
    
    var registerAlertTitle = ""
    
    var registerAlertMessage = ""
}

class RegisterInteractorMock: RegisterInteractor {

    var certificateManager: CertificateManager = MockCertificateManager(state: MockUserState())

    var registerWasCalled = false

    var presenter: RegisterPresenterImplementation!
    
    func register(details: RegistrationDetails) {
        registerWasCalled = true
    }
}

class RegisterRouterMock: RegisterRouter {
    var presenter: RegisterPresenterImplementation!
    
    var routerWasCalled = false
}
