//
//  TouristPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import CoreData
import Foundation

struct TouristPersistenceObject {
    let userId: UUID
    let email: String
    let profileImg: String?
    let name: String?
    let phone: String?
    let dateJoined: Date?
    let sex: Sex?
}

extension TouristPersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let touristDetails = persistenceObject as? TouristDetails,
              let id = touristDetails.id,
              let userId = UUID(uuidString: id),
              let email = touristDetails.email else {
            return nil
        }
        
        self.email = email
        self.profileImg = touristDetails.profileImg
        self.name = touristDetails.name
        self.phone = touristDetails.phone
        self.dateJoined = touristDetails.dateJoined
        self.sex = Sex(rawValue: touristDetails.sex ?? "")
        self.userId = userId
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let touristDetails = TouristDetails(context: CoreDataContainer.managedObjectContext)
        setTouristDetails(touristDetails: touristDetails)
        return touristDetails
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let touristDetails = persistenceObject as? TouristDetails else {
            return
        }
        setTouristDetails(touristDetails: touristDetails)
    }
    
    private func setTouristDetails(touristDetails: TouristDetails) {
        touristDetails.id = userId.uuidString
        touristDetails.dateJoined = dateJoined
        touristDetails.email = email
        touristDetails.sex = sex?.rawValue
        touristDetails.name = name
        touristDetails.profileImg = profileImg
        touristDetails.phone = phone
    }
}

extension TouristPersistenceObject: Equatable {
}
