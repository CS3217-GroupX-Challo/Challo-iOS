//
//  HostPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

import CoreData
import Foundation

struct HostPersistenceObject {
    var userId: UUID
    var email: String
    var profileImg: String?
    var name: String?
    var phone: String?
    var dateJoined: Date?
    var sex: Sex?
}

extension HostPersistenceObject: CoreDataPersistenceObject {
    init?(entity: NSManagedObject) {
        guard let host = entity as? HostDetails,
              let userId = host.id,
              let email = host.email else {
            return nil
        }
        
        self.userId = userId
        self.email = email
        self.profileImg = host.profileImg
        self.name = host.name
        self.dateJoined = host.dateJoined
        self.phone = host.phone
        self.sex = Sex(rawValue: host.sex ?? "")
    }
    
    func convertToEntity() -> NSManagedObject {
        let hostDetails = HostDetails(context: CoreDataContainer.managedObjectContext)
        setHostDetails(hostDetails: hostDetails)
        return hostDetails
    }
    
    func updateEntity(entity: NSManagedObject) {
        guard let hostDetails = entity as? HostDetails else {
            return
        }
        setHostDetails(hostDetails: hostDetails)
    }
    
    private func setHostDetails(hostDetails: HostDetails) {
        hostDetails.id = userId
        hostDetails.dateJoined = dateJoined
        hostDetails.email = email
        hostDetails.sex = sex?.rawValue
        hostDetails.name = name
        hostDetails.profileImg = profileImg
        hostDetails.phone = phone
    }
}

extension HostPersistenceObject: Equatable {
}
