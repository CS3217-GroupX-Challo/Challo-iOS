//
//  RegisterDelegate.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

protocol RegisterDelegate: AnyObject {

    func registrationProcessCompleted(response: RegisterResponse)
}
