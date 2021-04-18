//
//  TrailStore.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import Foundation

class TrailStore: StoreProtocol {
    typealias Model = Trail
    typealias PersistenceObject = TrailPersistenceObject
    typealias Convertor = TrailModelConvertor
    typealias Repo = AnyPersistenceRepoProtocol<TrailPersistenceObject>
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
