//
//  BookingDetails.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

struct BookingDetails {

    var touristId: UUID
    var guideId: UUID
    var trailId: UUID
    var date: Date
    var numberOfPax: Int
    var totalFee: Double

    func convertToJSON() -> NetworkManager.JSON {
        var json = NetworkManager.JSON()
        json[Key.touristId] = touristId.uuidString
        json[Key.guideId] = guideId.uuidString
        json[Key.trailId] = trailId.uuidString
        json[Key.fee] = String(totalFee)
        json[Key.date] = date.destruct()
        return json
    }
}
