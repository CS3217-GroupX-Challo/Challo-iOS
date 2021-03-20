//
//  GuidesAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

class GuideAPI {
    // TODO: Add in post/put/delete methods

    typealias JSON = NetworkManager.JSON

    let guideParser = GuideAPIParser()
    let trailParser = TrailAPIParser()

    func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        let api = APINetwork.api
        api.get(url: url,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            let guides = self.guideParser.parseGuides(response: response)
            var updatedGuidesWithTrail: [Guide] = []
            for var guide in guides {
                api.get(url: "/guide/trail/" + guide.userId.uuidString,
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
        let api = APINetwork.api
        api.get(url: url + "/" + guideId.uuidString,
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
