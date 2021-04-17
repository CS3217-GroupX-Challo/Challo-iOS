//
//  PersistenceObjectProtocol.swift
//  Challo
//
//  Created by Kester Ng on 10/4/21.
//

/// Structures in persistence must inherit to this protocol
/// Converts to the entityt based on choice of persistence
/// eg NSManagedObject for core data, RealmObject for Realm
protocol PersistenceObjectProtocol {
    associatedtype Entity // entity in persistence
    
    func convertToEntity() -> Entity
    func updateEntity(entity: Entity)
    init?(entity: Entity)
}
