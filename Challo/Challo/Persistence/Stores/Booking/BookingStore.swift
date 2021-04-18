//
//  BookingStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class BookingStore: StoreProtocol {
    typealias Model = Booking
    typealias PersistenceObject = BookingPersistenceObject
    typealias Convertor = BookingModelConvertor
    typealias Repo = AnyPersistenceRepoProtocol<BookingPersistenceObject>
    
    var repository: Repo
    var convertor: Convertor
    
    init(repository: Repo, convertor: Convertor) {
        self.repository = repository
        self.convertor = convertor
    }
}
