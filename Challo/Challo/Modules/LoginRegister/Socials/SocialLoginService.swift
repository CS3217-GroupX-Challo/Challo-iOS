//
//  SocialLoginService.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol SocialLoginService {

    var delegate: SocialLoginDelegate? { get set }
    func login()
}
