//
//  GuideAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol GuideAPIProtocol: APIProtocol {
    func getGuides(callback: @escaping ([Guide]) -> Void, url: String)
    func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String)
}

extension GuideAPIProtocol {
    func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        getGuides(callback: callback, url: url)
    }
    
    func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String = "/guide") {
        getGuide(guideId: guideId, callback: callback, url: url)
    }
}
