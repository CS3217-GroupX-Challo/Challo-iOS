//
//  AreaPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import CoreData
import Foundation

struct AreaPersistenceObject {
    let areaId: UUID
    let village: String
    let division: String
    let state: String
    let country: String
}

extension AreaPersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let area = persistenceObject as? AreaDetails,
              let village = area.village,
              let division = area.division,
              let state = area.state,
              let country = area.country,
              let id = area.id,
              let areaId = UUID(uuidString: id) else {
            return nil
        }
        
        self.areaId = areaId
        self.country = country
        self.village = village
        self.state = state
        self.division = division
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let areaDetails = AreaDetails(context: CoreDataContainer.managedObjectContext)
        setAreaDetails(areaDetails: areaDetails)
        return areaDetails
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let areaDetails = persistenceObject as? AreaDetails else {
            return
        }
        
        setAreaDetails(areaDetails: areaDetails)
    }
    
    private func setAreaDetails(areaDetails: AreaDetails) {
        areaDetails.id = areaId.uuidString
        areaDetails.village = village
        areaDetails.division = division
        areaDetails.state = state
        areaDetails.country = country
    }
}

// MARK: - Equtable
extension AreaPersistenceObject: Equatable {
}