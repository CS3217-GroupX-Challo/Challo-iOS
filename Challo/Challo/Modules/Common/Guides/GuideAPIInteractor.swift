//
//  GuideAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import Foundation

protocol GuideAPIInteractor {
    typealias JSON = AlamofireManager.JSON
    typealias HEADER = AlamofireManager.HEADER
    
    func parseGuides(response: JSON) -> [Guide]
}

extension GuideAPIInteractor {
    func parseGuides(response: JSON) -> [Guide] {
        guard let data = response["data"],
              let guidesInfo = data as? [JSON] else {
            return []
        }
        
        var guides: [Guide] = []
        
        for guideInfo in guidesInfo {
            if let guide = convertJSONToGuide(json: guideInfo) {
                guides.append(guide)
            }
        }
        
        return guides
    }
    
    func convertJSONToGuide(json: JSON) -> Guide? {
        guard let userId = UUID(uuidString: json["userId"] as? String ?? ""),
              let email = json["email"] as? String,
              let availabilities = json["daysAvailable"] as? [String] else {
            return nil
        }
        
        var daysAvailable: [Days] = []
        for availability in availabilities {
            if let day = Days(rawValue: availability) {
                daysAvailable.append(day)
            }
        }
        
        let profileImg: String? = json["profileImg"] as? String
        let name: String? = json["name"] as? String
        let phone: String? = json["phone"] as? String
        let dateJoined: Date? = json["dateJoined"] as? Date
        let sexString: String? = json["sex"] as? String
        
        var sex: Sex?
        if let string = sexString {
            if string.lowercased().contains("male") {
                sex = Sex.Male
            } else {
                sex = Sex.Female
            }
        }
                
        let unavailableDates: [Date]? = json["unavailableDates"] as? [Date]
        let yearsOfExperience: Int? = json["yearsOfExperience"] as? Int
        let languages: [String]? = json["languages"] as? [String]
        let accreditations: [String]? = json["accreditations"] as? [String]
        let biography: String? = json["biography"] as? String
        
        return Guide(userId: userId, email: email, profileImg: profileImg,
                     name: name, phone: phone, dateJoined: dateJoined,
                     sex: sex, daysAvailable: daysAvailable, trails: [],
                     unavailableDates: unavailableDates, yearsOfExperience: yearsOfExperience,
                     languages: languages,
                     accreditations: accreditations, biography: biography)
    }
}
