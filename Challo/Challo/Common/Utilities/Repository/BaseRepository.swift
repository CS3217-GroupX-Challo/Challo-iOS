//
//  BaseRepository.swift
//  Challo
//
//  Created by Shao Yi on 28/3/21.
//

import Foundation

/// A basic implementation of the repository, keyed using UUID
class BaseRepository<T>: Repository {
    var repository: [UUID:T]
    
    init() {
        repository = [UUID:T]()
    }
    
    func getAll() -> [T] {
        Array(repository.values)
    }
    
    func getByKey(_ key: UUID) -> T? {
        repository[key]
    }
    
    private func checkIfKeyExists(_ key: UUID) -> Bool {
        repository.keys.contains(key)
    }
    
    func store(_ entity: T, key: UUID?) -> UUID? {
        let keyToUse = key ?? UUID()
        
        guard checkIfKeyExists(keyToUse) else {
            return nil
        }
        repository[keyToUse] = entity
        return keyToUse
    }
    
    func deleteByKey(_ key: UUID) -> T? {
        repository.removeValue(forKey: key)
    }
    
    func updateByKey(entity: T, key: UUID) -> T? {
        guard checkIfKeyExists(key) else {
            return nil
        }
        repository[key] = entity
        return entity
    }
}
