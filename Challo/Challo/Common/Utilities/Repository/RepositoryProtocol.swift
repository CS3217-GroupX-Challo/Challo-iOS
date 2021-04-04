//
//  RepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 28/3/21.
//

import Foundation

/// Protocol for the repository pattern
///
/// A repository is an abstraction of the data layer and serves as the central component for handling domain objects
protocol RepositoryProtocol {
    /// The type of domain object for which this repository contains
    associatedtype Entity
    
    /// The type of key that uniquely identifies an entity
    associatedtype Key: Hashable
    
    /// Retrieves all entities found in the repository
    func getAll() -> [Entity]
    
    /// Retrieves an entity by its unique key
    /// - Returns
    ///     - the retrieved entity matched by the given key, or nil if no entity is matched by the key
    func getByKey(_ key: Key) -> Entity?
    
    /// Stores an entity into repository.
    ///
    /// An optional key can be provided to specify the unique idenitifer of the entity.
    /// If a key is not provided, the repository should auto generate a key
    /// - Parameters
    ///     - `entity`: the entity to store inside the repository
    ///     - `key`: an optional key can be provided to specify the unique idenitifer of the entity
    /// - Returns
    ///     - the key that unique identifies the stored entity,
    ///     - or nil if the given key is already found in the repository and store is not performed
    func insert(_ entity: Entity, key: Key) -> Key?
    
    /// Delete an entity by its unique key
    /// A delete operation fails when the key does not exist in the repository
    /// - Returns
    ///     - the deleted entity, or nil if deletion fails.
    func deleteByKey(_ key: Key) -> Entity?
    
    /// Delete an entity by its unique key
    /// An update operation fails when the key does not exist in the repository
    /// - Parameters
    ///     - `entity`: the updated entity
    ///     - `key`: the unique identifier of this entity
    /// - Returns
    ///     - the updated entity, or nil if deletion fails.
    func updateByKey(entity: Entity, key: Key) -> Entity?
    
    /// Updates an entity with if the key matches an existing entity
    /// Else, the given entity is inserted into the repository
    func upsert(entity: Entity, key: Key) -> Entity
    
    /// Commit any transcations in the repository
    /// Units of works pattern, to reduce number of writes to repo
    func commit()
}
