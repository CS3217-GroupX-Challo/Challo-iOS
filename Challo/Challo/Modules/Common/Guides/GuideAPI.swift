//
//  GuidesAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

protocol GuideAPI: GuideAPIInteractor, TrailAPIInteractor {
    // TODO: Add in post/put/delete methods
    
    func getGuides(url: String, callback: @escaping ([Guide]) -> Void)
}

extension GuideAPI {
    func getGuides(url: String = "/guide", callback: @escaping ([Guide]) -> Void) {
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
                        headers: HEADER()) { response, error in
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
}
