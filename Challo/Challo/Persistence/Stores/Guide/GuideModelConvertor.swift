//
//  GuideModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

/*
class GuideModelConvertor {
    private let areaModelConvertor: AreaModelConvertor
    private let trailModelConvertor: TrailModelConvertor
    
    init(areaModelConvertor: AreaModelConvertor,
         trailModelConvertor: TrailModelConvertor) {
        self.areaModelConvertor = areaModelConvertor
        self.trailModelConvertor = trailModelConvertor
    }
    
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
*/

class GuideModelConvertor: ModelConvertor {
    typealias Model = Guide
    typealias PersistenceObject = GuidePersistenceObject
    
    private let areaModelConvertor: AreaModelConvertor
    private let trailModelConvertor: TrailModelConvertor
    
    init(areaModelConvertor: AreaModelConvertor,
         trailModelConvertor: TrailModelConvertor) {
        self.areaModelConvertor = areaModelConvertor
        self.trailModelConvertor = trailModelConvertor
    }
    
    func convertModelToPersistenceObject(model: Guide) -> GuidePersistenceObject {
        let trailObjects = model.trails.map { trail in
            trailModelConvertor.convertModelToPersistenceObject(model: trail)
        }
        
        var areaObject: AreaPersistenceObject?
        if let location = model.location {
            areaObject = areaModelConvertor.convertModelToPersistenceObject(model: location)
        }
        
        return GuidePersistenceObject(userId: model.userId, email: model.email,
                                      profileImg: model.profileImg,
                                      name: model.name, phone: model.phone,
                                      dateJoined: model.dateJoined, location: areaObject,
                                      sex: model.sex, rating: model.rating,
                                      daysAvailable: model.daysAvailable, trails: trailObjects,
                                      unavailableDates: model.unavailableDates,
                                      yearsOfExperience: model.yearsOfExperience,
                                      languages: model.languages, accreditations: model.accreditations,
                                      biography: model.biography, hobbies: model.hobbies,
                                      memorableExperiences: model.memorableExperiences)
    }
    
    func convertPersistenceObjectToModel(object: GuidePersistenceObject) -> Guide {
        let trails = object.trails.map { trailObject in
            trailModelConvertor.convertPersistenceObjectToModel(object: trailObject)
        }
        
        var location: Area?
        if let area = object.location {
            location = areaModelConvertor.convertPersistenceObjectToModel(object: area)
        }
        
        return Guide(userId: object.userId, email: object.email,
                     profileImg: object.profileImg, name: object.name,
                     phone: object.phone, dateJoined: object.dateJoined,
                     location: location, sex: object.sex,
                     rating: object.rating, daysAvailable: object.daysAvailable,
                     trails: trails, unavailableDates: object.unavailableDates,
                     yearsOfExperience: object.yearsOfExperience, languages: object.languages,
                     accreditations: object.accreditations, biography: object.biography,
                     hobbies: object.hobbies, memorableExperiences: object.memorableExperiences)
    }
}
