//
//  GuideAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import Foundation

protocol GuideAPIInteractor: AreaAPIInteractor {
    typealias JSON = [String: Any]
    
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
        guard let userId = UUID(uuidString: json[Key.userId] as? String ?? ""),
              let email = json[Key.email] as? String,
              let availabilities = json[Key.daysAvailable] as? [String] else {
            return nil
        }
        
        // intermediate properties to be converted to its own struct
        let sexString: String? = json[Key.sex] as? String
        let areaDetails: JSON? = json[Key.area] as? JSON
        let ratingString: String? = json[Key.rating] as? String
                
        let profileImg: String? = json[Key.profileImage] as? String
        let name: String? = json[Key.name] as? String
        let phone: String? = json[Key.phone] as? String
        let dateJoined: Date? = json[Key.dateJoined] as? Date
        let daysAvailable: [Days] = getAvailableDays(availabilites: availabilities)
        let sex: Sex? = getSex(sexString: sexString)
        let unavailableDates: [Date]? = json[Key.unavailableDates] as? [Date]
        let yearsOfExperience: Int? = json[Key.yearsOfExperience] as? Int
        let languages: [String]? = json[Key.languages] as? [String]
        let accreditations: [String]? = json[Key.accreditations] as? [String]
        let biography: String? = json[Key.biography] as? String
        let memorableExperiences: String? = json[Key.memorableExperiences] as? String
        let hobbies: String? = json[Key.hobbies] as? String
        let area: Area? = self.convertJSONToArea(json: areaDetails ?? JSON())
        let rating: Decimal? = Decimal(string: ratingString ?? "")
        let activeSince: String? = json[Key.activeSince] as? String
        
        var guide = Guide(userId: userId, email: email, profileImg: profileImg,
                          name: name, phone: phone, dateJoined: dateJoined, location: area,
                          sex: sex, daysAvailable: daysAvailable, trails: [],
                          unavailableDates: unavailableDates, yearsOfExperience: yearsOfExperience,
                          languages: languages,
                          accreditations: accreditations, biography: biography,
                          hobbies: hobbies, memorableExperiences: memorableExperiences)
        guide.rating = rating ?? Decimal.zero
        guide.dateJoined = Date.construct(with: activeSince ?? "")
        return guide
    }
    
    private func getAvailableDays(availabilites: [String]) -> [Days] {
        var daysAvailable: [Days] = []
        for availability in availabilites {
            if let day = Days(rawValue: availability) {
                daysAvailable.append(day)
            }
        }
        return daysAvailable
    }
    
    private func getSex(sexString: String?) -> Sex? {
        var sex: Sex
        guard let string = sexString else {
            return nil
            
        }
        
        if string.lowercased().contains("male") {
            sex = Sex.Male
        } else {
            sex = Sex.Female
        }
        return sex
    }
}
