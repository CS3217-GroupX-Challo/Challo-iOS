//
//  EntityRepositoryProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 17/4/21.
//

protocol LocalStorageRetriever {
    associatedtype Model
    associatedtype LocalStore: StoreProtocol where LocalStore.Model == Model

    var localStore: LocalStore { get }

    func retrieveFromLocalStore() -> [Model]
    func saveToLocalStore(models: [Model])
}

extension LocalStorageRetriever {

    func retrieveFromLocalStore() -> [Model] {
        localStore.getAll()
    }

    func saveToLocalStore(models: [Model]) {
        localStore.save(models: models)
    }
}
