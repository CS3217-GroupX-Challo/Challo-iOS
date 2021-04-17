//
//  StoreProtocol.swift
//  Challo
//
//  Created by Kester Ng on 17/4/21.
//

protocol StoreProtocol {
    associatedtype Model
    associatedtype PersistenceObject
    associatedtype Convertor: ModelConvertor where Convertor.Model == Model,
                                                   Convertor.PersistenceObject == PersistenceObject
    associatedtype Repo: PersistenceRepoProtocol where Repo.PersistenceObject == PersistenceObject
    
    var convertor: Convertor { get set }
    var repository: Repo { get set }
    
    func getAll() -> [Model]
    func save(models: [Model])
}

extension StoreProtocol {
    func getAll() -> [Model] {
        let objects = repository.getAll()
        return objects.map { object in
            convertor.convertPersistenceObjectToModel(object: object)
        }
    }
    
    func save(models: [Model]) {
        let objects = models.map { model in
            convertor.convertModelToPersistenceObject(model: model)
        }
        repository.save(objects: objects)
    }
}
