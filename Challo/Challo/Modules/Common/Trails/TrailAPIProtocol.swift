//
//  TrailAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol TrailAPIProtocol: APIProtocol {
    func getTrails(callback: @escaping ([Trail]) -> Void)
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String)
}

extension TrailAPIProtocol {    
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void) {
        getTrail(trailId: trailId, callback: callback, url: "/trail")
    }
}
