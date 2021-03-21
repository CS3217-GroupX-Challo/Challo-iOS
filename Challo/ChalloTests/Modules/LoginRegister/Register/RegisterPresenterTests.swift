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

    func testShowAlert_showAlertVariableToggled() {
        presenter.showRegisterFailureAlert()
        XCTAssertTrue(presenter.isShowingRegisterFailureAlert, "Register alert variable not toggled")
    }
}

private class RegisterPresenterImplementation: RegisterPresenter {

    var interactor: RegisterInteractor!
    
    var router: RegisterRouter?
    
    var name = ""
    
    var phone = ""
    
    var email = ""
    
    var password = ""
    
    var isShowingRegisterFailureAlert = false
}

private class RegisterInteractorMock: RegisterInteractor {

    var registerWasCalled = false

    var presenter: RegisterPresenter!
    
    func register(details: RegistrationDetails) {
        registerWasCalled = true
    }
}
