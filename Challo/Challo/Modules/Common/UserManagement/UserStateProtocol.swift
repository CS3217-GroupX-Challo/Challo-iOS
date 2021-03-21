//
//  UserStateProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 21/3/21.
//

import Combine

protocol UserStateProtocol: AnyObject {

    var loggedIn: Bool { get set }
    var email: String { get set }
    var name: String { get set }
    var token: String { get set }
    var userId: String { get set }
    var certificate: UserCertificate? { get }
    var user: User? { get set }
    
    func storeCertificate(certificate: UserCertificate)
}

extension UserStateProtocol {

    func storeCertificate(certificate: UserCertificate) {
        loggedIn = true
        name = certificate.name
        email = certificate.email
        token = certificate.token
        userId = certificate.userId
        user = certificate.user
    }
}
