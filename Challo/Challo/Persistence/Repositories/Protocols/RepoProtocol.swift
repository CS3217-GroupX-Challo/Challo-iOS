//
//  RepoProtocol.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

protocol RepoProtocol {
    associatedtype PersistenceObject
    
    func getAll() -> [PersistenceObject]
    func save(objects: [PersistenceObject])
}
