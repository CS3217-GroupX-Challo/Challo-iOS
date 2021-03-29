//
//  TrailAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol TrailAPIProtocol: APIProtocol {
    func getTrails(callback: @escaping ([Trail]) -> Void, url: String)
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String)
}

extension TrailAPIProtocol {
    func getTrails(callback: @escaping ([Trail]) -> Void, url: String = "/trail") {
        getTrails(callback: callback, url: url)
    }
    
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        getTrail(trailId: trailId, callback: callback, url: url)
    }
}
