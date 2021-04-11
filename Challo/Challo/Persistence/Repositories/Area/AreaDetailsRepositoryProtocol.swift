//
//  AreaRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

protocol AreaDetailsRepositoryProtocol {
    func getAllAreas() -> [AreaPersistenceObject]
    func saveAreas(areaObjects: [AreaPersistenceObject])
}
