//
//  GuideStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class GuideStore: StoreProtocol {
    typealias Model = Guide
    typealias PersistenceObject = GuidePersistenceObject
    typealias Convertor = GuideModelConvertor
    typealias Repo = GuideDetailsRepository
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
