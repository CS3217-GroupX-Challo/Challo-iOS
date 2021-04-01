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
<<<<<<< HEAD
        XCTAssertTrue(presenter.isShowingRegisterAlert, "Register alert variable not toggled")
=======
        XCTAssertTrue(presenter.isShowingRegisterFailureAlert, "Register failure alert variable not toggled")
>>>>>>> master
    }

    func testShowSuccessAlert_showAlertVariableToggled() {
        presenter.showRegisterSuccessAlert()
<<<<<<< HEAD
        XCTAssertTrue(presenter.isShowingRegisterAlert, "Register alert variable not toggled")
=======
        XCTAssertTrue(presenter.isShowingRegisterSuccessAlert, "Register success alert variable not toggled")
>>>>>>> master
    }
}

class RegisterPresenterImplementation: RegisterPresenter {

    var interactor: RegisterInteractor!
    
    var router: RegisterRouter?
    
    var name = ""
    
    var phone = ""
    
    var email = ""
    
    var password = ""
    
    var isShowingRegisterAlert = false
    
    var registerAlertTitle = ""
    
    var registerAlertMessage = ""
}

private class RegisterInteractorMock: RegisterInteractor {

    var certificateManager: CertificateManager = MockCertificateManager(state: MockUserState())

    var registerWasCalled = false

    var presenter: RegisterPresenter!
    
    func register(details: RegistrationDetails) {
        registerWasCalled = true
    }
}
