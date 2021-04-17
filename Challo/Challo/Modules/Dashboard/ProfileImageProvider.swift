//
//  ProfileImageProvider.swift
//  Challo
//
//  Created by Ying Gao on 17/4/21.
//

import Foundation

protocol ProfileImageProvider: ObservableObject {
    var userState: UserStateProtocol { get }
    var profileImgPath: String { get }
}

extension ProfileImageProvider {
    var profileImgPath: String {
        userState.profileImg
    }
}
