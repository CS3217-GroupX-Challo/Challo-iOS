//
//  ModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

protocol ModelConvertor {
    associatedtype Model
    associatedtype PersistenceObject
    
    func convertModelToPersistenceObject(model: Model) -> PersistenceObject
    func convertPersistenceObjectToModel(object: PersistenceObject) -> Model
}
