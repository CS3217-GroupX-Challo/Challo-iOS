//
//  GuidePersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import CoreData
import Foundation

struct GuidePersistenceObject {
    let userId: UUID
    let email: String
    let profileImg: String?
    let name: String?
    let phone: String?
    let dateJoined: Date?
    var location: AreaPersistenceObject?
    let sex: Sex?
    let rating: Double
    let daysAvailable: [Days]
    let trails: [TrailPersistenceObject]
    var unavailableDates: [Date]?
    let yearsOfExperience: Int?
    let languages: [String]?
    let accreditations: [String]?
    let biography: String?
    let hobbies: String?
    let memorableExperiences: String?
}

extension GuidePersistenceObject: CoreDataPersistenceObject {
    // swiftlint:disable function_body_length
    init?(entity: NSManagedObject) {
        guard let guide = entity as? GuideDetails,
              let id = guide.id,
              let userId = UUID(uuidString: id),
              let email = guide.email,
              let daysAvailableString = guide.daysAvailable else {
            return nil
        }
        
        self.userId = userId
        self.email = email
        self.profileImg = guide.profileImg
        self.name = guide.name
        self.phone = guide.phone
        self.dateJoined = guide.dateJoined
        
        if let area = guide.location {
            self.location = AreaPersistenceObject(entity: area)
        }
        
        self.sex = Sex(rawValue: guide.sex ?? "")
        self.rating = guide.rating
        self.yearsOfExperience = Int(guide.experience)
        self.biography = guide.biography
        self.hobbies = guide.hobbies
        self.memorableExperiences = guide.memorableExperiences
        
        var trailObjects = [TrailPersistenceObject]()
        if let trailsPersisted = guide.trails {
            for trail in trailsPersisted {
                if let trailDetails = trail as? TrailDetails,
                   let trailObject = TrailPersistenceObject(entity: trailDetails) {
                    trailObjects.append(trailObject)
                }
            }
        }
        self.trails = trailObjects
        self.languages = guide.langauges?.constructArray()
        self.accreditations = guide.accreditations?.constructArray()
        
        var daysAvailable = [Days]()
        let daysStringArray = daysAvailableString.constructArray()
        for dayString in daysStringArray {
            if let day = Days(rawValue: dayString) {
                daysAvailable.append(day)
            }
        }
        self.daysAvailable = daysAvailable
        
        if let unavailableDatesString = guide.unavailableDates {
            let stringArray = unavailableDatesString.constructArray()
            var unavailableDates = [Date]()
            for string in stringArray {
                if let timeInterval = TimeInterval(string) {
                    unavailableDates.append(Date(timeIntervalSince1970: timeInterval))
                }
            }
            self.unavailableDates = unavailableDates
        }
    }
    
    func convertToEntity() -> NSManagedObject {
        let guideDetails = GuideDetails(context: CoreDataContainer.managedObjectContext)
        setGuideDetails(guideDetails: guideDetails)
        return guideDetails
    }
    
    func updateEntity(entity: NSManagedObject) {
        guard let guideDetails = entity as? GuideDetails else {
            return
        }
        
        setGuideDetails(guideDetails: guideDetails)
    }
    
    private func setGuideDetails(guideDetails: GuideDetails) {
        guideDetails.accreditations = String(array: accreditations ?? [])
        guideDetails.biography = biography
        guideDetails.dateJoined = dateJoined
        guideDetails.email = email
        guideDetails.experience = Int64(yearsOfExperience ?? 0)
        guideDetails.hobbies = hobbies
        guideDetails.id = userId.uuidString
        guideDetails.langauges = String(array: languages ?? [])
        guideDetails.memorableExperiences = memorableExperiences
        guideDetails.name = name
        guideDetails.phone = phone
        guideDetails.profileImg = profileImg
        guideDetails.rating = rating
        guideDetails.sex = sex?.rawValue
        
        let unavailableDateStringArray = (unavailableDates ?? []).map { date in
            date.timeIntervalSince1970.description
        }
        guideDetails.unavailableDates = String(array: unavailableDateStringArray)
        guideDetails.daysAvailable = String(array: daysAvailable.map { day in
            day.rawValue
        })
    }
}

extension GuidePersistenceObject: Equatable {
}
