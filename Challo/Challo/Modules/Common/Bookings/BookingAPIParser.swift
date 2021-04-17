//
//  BookingAPIParser.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class BookingAPIParser: APIParser {

    typealias JSON = NetworkManager.JSON

    func extractBookingsJSON(response: JSON) -> [JSON] {
        guard let data = response["data"],
              let bookingsInfo = data as? [JSON] else {
            return []
        }
        
        return bookingsInfo
    }

    func extractBookingID(json: JSON) -> UUID? {
        UUID(uuidString: json[Key.bookingId] as? String ?? "")
    }

    func extractTrailID(json: JSON) -> UUID? {
        UUID(uuidString: json[Key.trailId] as? String ?? "")
    }

    func extractTouristID(json: JSON) -> UUID? {
        UUID(uuidString: json[Key.touristId] as? String ?? "")
    }

    func extractGuideID(json: JSON) -> UUID? {
        UUID(uuidString: json[Key.guideId] as? String ?? "")
    }
    
    func convertJSONToBooking(json: JSON,
                              guide: Guide,
                              trail: Trail,
                              tourist: Tourist,
                              review: Review?) -> Booking? {
        guard let bookingID = UUID(uuidString: json[Key.bookingId] as? String ?? ""),
              let createdAtString = json[Key.createdAt] as? String,
              let dateString = json[Key.date] as? String,
              let statusString = json[Key.status] as? String else {
            return nil
        }
    
        guard let date = Date.construct(with: dateString),
              let createdAt = Date.construct(with: createdAtString),
              let bookingStatus = BookingStatus(rawValue: statusString) else {
            return nil
        }
    
        let fee = Double(convertJSONIntValueToInt(json[Key.fee]))
    
        return Booking(bookingId: bookingID,
                       fee: fee,
                       date: date,
                       createdAt: createdAt,
                       status: bookingStatus,
                       guide: guide,
                       trail: trail,
                       tourist: tourist,
                       review: review)
    }
}
