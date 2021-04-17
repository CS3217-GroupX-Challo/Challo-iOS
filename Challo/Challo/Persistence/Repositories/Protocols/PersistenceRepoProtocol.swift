//
//  RepoProtocol.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

protocol PersistenceRepoProtocol {
    associatedtype PersistenceObject
    
    func getAll() -> [PersistenceObject]
    func save(objects: [PersistenceObject])
}
