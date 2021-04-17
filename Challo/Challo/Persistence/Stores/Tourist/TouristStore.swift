//
//  TouristStore.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TouristStore: StoreProtocol {
    typealias Model = Tourist
    typealias PersistenceObject = TouristPersistenceObject
    typealias Convertor = TouristModelConvertor
    typealias Repo = AnyRepoProtocol<TouristPersistenceObject>
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
