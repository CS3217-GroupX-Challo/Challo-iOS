//
//  ModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

/// Protocol to convert from external model to persistence model.
/// Associated model is for the external model (ie booking)
/// PersistenceObject is for the corresponding persistence model.
protocol ModelConvertor {
    associatedtype Model
    associatedtype PersistenceObject
    
    func convertModelToPersistenceObject(model: Model) -> PersistenceObject
    func convertPersistenceObjectToModel(object: PersistenceObject) -> Model
}
