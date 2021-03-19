//
//  GuidesAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

protocol GuideAPI: GuideAPIInteractor, TrailAPIInteractor {
    // TODO: Add in post/put/delete methods
    
    func getGuides(callback: @escaping ([Guide]) -> Void, url: String)
    func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String)
}

extension GuideAPI {
    func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            let guides = self.parseGuides(response: response)
            var updatedGuidesWithTrail: [Guide] = []
            for var guide in guides {
                api.get(url: "/guide/trail/" + guide.userId.uuidString,
                        headers: [String: String]()) { response, error in
                    if error != nil {
                        return
                    }
                    guide.trails = parseTrail(response: response)
                    updatedGuidesWithTrail.append(guide)
                    callback(updatedGuidesWithTrail)
                }
            }
        }
    }
    
    func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String = "/guide") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + "/" + guideId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            guard let guideInfo = response["data"] as? JSON,
                  let guide = convertJSONToGuide(json: guideInfo) else {
                return
            }
            
            callback(guide)
        }
    }
}
