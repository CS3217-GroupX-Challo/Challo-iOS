//
//  DashboardInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class TouristDashboardInteractor: InteractorProtocol {
    
    typealias Entity = Booking
    
    weak var presenter: TouristDashboardPresenter!

    let bookingRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol
    let userAPI: UserAPIProtocol
    let updateUserChat: ((_ name: String, _ email: String) -> Void)

    init(bookingRepository: BookingRepositoryProtocol, userState: UserStateProtocol, userAPI: UserAPIProtocol,
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void)) {
        self.bookingRepository = bookingRepository
        self.userState = userState
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
    }

    func getAllEntities() {
        guard let id = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForTouristAndRefresh(id: id, didRefresh: presenter.didPopulateBookings)
    }
    
    func getCachedEntities() -> [Booking] {
        bookingRepository.getAll()
    }

    func initialFetch() {
        getAllEntities()
    }
}

// MARK: Filter and sort bookings
extension TouristDashboardInteractor {

    func sortBookings(bookings: [Booking]) -> [Booking] {
        bookings.sorted { bookingOne, bookingTwo in
            bookingOne.date < bookingTwo.date
        }
    }

    func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            ($0.status == .Paid || $0.status == .Pending) && $0.date > Date()
        }
    }

    func filterPastBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.date < Date()
        }
    }
}
    
// MARK: Update User Logic
extension TouristDashboardInteractor: ProfileUpdaterInteractor { }
