//
//  AreaStore.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

class AreaStore: StoreProtocol {
    typealias Model = Area
    typealias PersistenceObject = AreaPersistenceObject
    typealias Convertor = AreaModelConvertor
    typealias Repo = AnyPersistenceRepoProtocol<AreaPersistenceObject>
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
