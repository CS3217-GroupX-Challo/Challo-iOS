//
//  HostStore.swift
//  Challo
//
//  Created by Kester Ng on 18/4/21.
//

class HostStore: StoreProtocol {
    typealias Model = Host
    typealias PersistenceObject = HostPersistenceObject
    typealias Convertor = HostModelConvertor
    typealias Repo = AnyPersistenceRepoProtocol<HostPersistenceObject>
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
