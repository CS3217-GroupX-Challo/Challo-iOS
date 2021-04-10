//
//  PersistenceObjectProtocol.swift
//  Challo
//
//  Created by Kester Ng on 10/4/21.
//

/// Structures in persistence must inherit to this protocol
/// Converts to Persistence object based on choice of persistence
/// eg NSManagedObject for core data, RealmObject for Realm
protocol PersistenceObjectProtocol {
    associatedtype PersistenceObject
    
    func convertToPersistenceObject() -> PersistenceObject
    init?(persistenceObject: PersistenceObject)
}
