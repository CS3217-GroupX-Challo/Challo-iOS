//
//  GuideModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

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
