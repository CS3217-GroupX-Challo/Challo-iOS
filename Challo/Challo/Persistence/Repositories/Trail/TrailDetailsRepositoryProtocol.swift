//
//  TrailDetailsRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

protocol TrailDetailsRepositoryProtocol {
    func getAllTrails() -> [TrailPersistenceObject]
    func saveTrails(trailObjects: [TrailPersistenceObject])
}
