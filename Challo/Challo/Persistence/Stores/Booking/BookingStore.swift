//
//  BookingStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class BookingStore {
    private let bookingModelConvertor: BookingModelConvertor
    private let bookingRepository: BookingInfoRepositoryProtocol
    
    init(bookingModelConvertor: BookingModelConvertor,
         bookingRepository: BookingInfoRepositoryProtocol) {
        self.bookingRepository = bookingRepository
        self.bookingModelConvertor = bookingModelConvertor
    }
    
    func getAllBookings() -> [Booking] {
        let bookingObjects = bookingRepository.getAllBookings()
        return bookingObjects.map { bookingobject in
            bookingModelConvertor.convertPersistenceObjectToModel(object: bookingobject)
        }
    }
    
    func saveBookings(bookings: [Booking]) {
        let bookingObjects = bookings.map { booking in
            bookingModelConvertor.convertModelToPersistenceObject(model: booking)
        }
        
        bookingRepository.saveBookings(bookingObjects: bookingObjects)
    }
}
