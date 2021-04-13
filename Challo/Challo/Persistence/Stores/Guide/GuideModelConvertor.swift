//
//  GuideModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import Foundation

struct GuideModelConvertor {
    private let areaModelConvertor: AreaModelConvertor
    private let trailModelConvertor: TrailModelConvertor
    
    func convertGuideToGuidePersistenceObject(guide: Guide) -> GuidePersistenceObject {
        let trailObjects = guide.trails.map { trail in
            trailModelConvertor.convertTrailToTrailPersistenceObject(trail: trail)
        }
        
        var areaObject: AreaPersistenceObject?
        if let location = guide.location {
            areaObject = areaModelConvertor.convertAreaToAreaPersistenceObject(area: location)
        }
        
        return GuidePersistenceObject(userId: guide.userId, email: guide.email,
                                      profileImg: guide.profileImg,
                                      name: guide.name, phone: guide.phone,
                                      dateJoined: guide.dateJoined, location: areaObject,
                                      sex: guide.sex, rating: guide.rating,
                                      daysAvailable: guide.daysAvailable, trails: trailObjects,
                                      unavailableDates: guide.unavailableDates,
                                      yearsOfExperience: guide.yearsOfExperience,
                                      languages: guide.languages, accreditations: guide.accreditations,
                                      biography: guide.biography, hobbies: guide.hobbies,
                                      memorableExperiences: guide.memorableExperiences)
    }
    
    func convertGuidePersistenceObject(guideObject: GuidePersistenceObject) -> Guide {
        let trails = guideObject.trails.map { trailObject in
            trailModelConvertor.convertTrailPersistenceObjectToTrail(trailObject: trailObject)
        }
        
        var location: Area?
        if let area = guideObject.location {
            location = areaModelConvertor.convertAreaPersistenceObjectToArea(areaObject: area)
        }
        
        return Guide(userId: guideObject.userId, email: guideObject.email,
                     profileImg: guideObject.profileImg, name: guideObject.name,
                     phone: guideObject.phone, dateJoined: guideObject.dateJoined,
                     location: location, sex: guideObject.sex,
                     rating: guideObject.rating, daysAvailable: guideObject.daysAvailable,
                     trails: trails, unavailableDates: guideObject.unavailableDates,
                     yearsOfExperience: guideObject.yearsOfExperience, languages: guideObject.languages,
                     accreditations: guideObject.accreditations, biography: guideObject.biography,
                     hobbies: guideObject.hobbies, memorableExperiences: guideObject.memorableExperiences)
    }
}
