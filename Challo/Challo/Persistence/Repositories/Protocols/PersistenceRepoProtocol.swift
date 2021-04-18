//
//  RepoProtocol.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

/// Protocol for persistence repositories
/// Associated type persistenceObject is the persistence model involved
protocol PersistenceRepoProtocol {
    associatedtype PersistenceObject
    
    func getAll() -> [PersistenceObject]
    func save(objects: [PersistenceObject])
}
