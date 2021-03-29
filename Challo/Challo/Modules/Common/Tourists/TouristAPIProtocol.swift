//
//  TouristAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol TouristAPIProtocol {
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String)
}

extension TouristAPIProtocol {
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        getTourist(userId: userId, callback: callback, url: url)
    }
}
