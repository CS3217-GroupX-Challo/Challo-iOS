//
//  Repository.swift
//  Challo
//
//  Created by Shao Yi on 28/3/21.
//

import Foundation

/// A base implementation of the repository, keyed using UUID
class Repository<T>: RepositoryProtocol {
    private var repository: [UUID: T]
    
    init(_ initialRepository: [UUID: T]? = nil) {
        repository = initialRepository ?? [UUID: T]()
    }
    
    func getAll() -> [T] {
        Array(repository.values)
    }
    
    func getByKey(_ key: UUID) -> T? {
        repository[key]
    }
    
    private func checkIfExistingKey(_ key: UUID) -> Bool {
        repository.keys.contains(key)
    }
    
    @discardableResult
    func insert(_ entity: T, key: UUID?) -> UUID? {
        let keyToUse = key ?? UUID()
        
        guard !checkIfExistingKey(keyToUse) else {
            return nil
        }
        repository[keyToUse] = entity
        return keyToUse
    }
    
    func deleteByKey(_ key: UUID) -> T? {
        repository.removeValue(forKey: key)
    }
    
    func updateByKey(entity: T, key: UUID) -> T? {
        guard checkIfExistingKey(key) else {
            return nil
        }
        repository[key] = entity
        return entity
    }
    
    func upsert(entity: T, key: UUID) -> T {
        repository[key] = entity
        return entity
    }
}
