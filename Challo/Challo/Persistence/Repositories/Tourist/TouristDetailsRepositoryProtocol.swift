//
//  TouristDetailsRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

protocol TouristDetailsRepositoryProtocol {
    func getAllTourists() -> [TouristPersistenceObject]
    func saveTourists(touristObjects: [TouristPersistenceObject])
}
