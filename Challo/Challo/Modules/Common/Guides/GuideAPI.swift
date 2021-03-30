//
//  GuidesAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

class GuideAPI: GuideAPIProtocol {
    // TODO: Add in post/put/delete methods

    typealias JSON = NetworkManager.JSON

    private let guideParser: GuideAPIParser
    private let trailParser: TrailAPIParser
    private let networkManager: NetworkManager

    init(guideParser: GuideAPIParser, trailParser: TrailAPIParser, networkManager: NetworkManager) {
        self.guideParser = guideParser
        self.trailParser = trailParser
        self.networkManager = networkManager
    }
    
    func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        networkManager.get(url: url,
                           headers: [String: String]()) { [weak self] response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            let guides = self.guideParser.parseGuides(response: response)
            var updatedGuidesWithTrail: [Guide] = []
            for var guide in guides {
                self.networkManager.get(url: "/guide/trail/" + guide.userId.uuidString,
                                        headers: [String: String]()) { response, error in
                    if error != nil {
                        return
                    }
                    guide.trails = self.trailParser.parseTrail(response: response)
                    updatedGuidesWithTrail.append(guide)
                    callback(updatedGuidesWithTrail)
                }
            }
        }
    }

    func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String = "/guide") {
        networkManager.get(url: url + "/" + guideId.uuidString,
                           headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            guard let guideInfo = response["data"] as? JSON,
                  let guide = self.guideParser.convertJSONToGuide(json: guideInfo) else {
                return
            }
            
            callback(guide)
        }
    }
}
