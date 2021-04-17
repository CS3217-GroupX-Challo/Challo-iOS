//
//  ReviewStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class ReviewStore: StoreProtocol {
    typealias Model = Review
    typealias PersistenceObject = ReviewPersistenceObject
    typealias Convertor = ReviewModelConvertor
    typealias Repo = ReviewDetailsRepository
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
