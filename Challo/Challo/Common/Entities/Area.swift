//
//  Area.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a geographical region
struct Area: Equatable {
    let areaId: UUID
    
    let village: String
    
    let division: String
    
    let state: String
    
    let country: String
}

extension Area {

    static var sampleAreaID: UUID! {
        UUID(uuidString: "892D85DD-DFEC-4A96-A5F8-14D28B59CD8A")
    }

    static var sampleArea: Area {
        Area(areaId: sampleAreaID, village: "Mukteshwar", division: "Kumaon",
             state: "Uttarakhand", country: "India")
    }

}
