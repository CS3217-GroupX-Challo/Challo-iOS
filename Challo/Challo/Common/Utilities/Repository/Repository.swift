//
//  Repository.swift
//  Challo
//
//  Created by Shao Yi on 28/3/21.
//

import Foundation

/// A base implementation of the repository
class Repository<K: Hashable, T>: RepositoryProtocol {
    private var repository: [K: T]
    
    init(_ initialRepository: [K: T]? = nil) {
        repository = initialRepository ?? [K: T]()
    }
    
    func getAll() -> [T] {
        Array(repository.values)
    }
    
    func getByKey(_ key: K) -> T? {
        repository[key]
    }
    
    private func checkIfExistingKey(_ key: K) -> Bool {
        repository.keys.contains(key)
    }
    
    @discardableResult
    func insert(_ entity: T, key: K) -> K? {
        guard !checkIfExistingKey(key) else {
            return nil
        }
        repository[key] = entity
        return key
    }
    
    func deleteByKey(_ key: K) -> T? {
        repository.removeValue(forKey: key)
    }
    
    func updateByKey(entity: T, key: K) -> T? {
        guard checkIfExistingKey(key) else {
            return nil
        }
        repository[key] = entity
        return entity
    }
    
    @discardableResult
    func upsert(entity: T, key: K) -> T {
        repository[key] = entity
        return entity
    }
}
