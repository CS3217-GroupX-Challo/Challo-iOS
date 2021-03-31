//
//  TrailBookingPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

class TrailBookingPresenter: ObservableObject {

    private var trail: Trail?
    private var pricePerPax: Int {
        (trail?.lowestFee) ?? 25
    }
    private var originalGuides = [Guide]()

    var pricePerPaxString: String {
        String(pricePerPax)
    }
    @Published var totalPriceString: String = "$0.00"
    @Published var selectedPax: Int = 0 {
        didSet {
            setTotalPriceString()
        }
    }
    @Published var paxRange = [1, 2, 3, 4, 5]
    @Published var selectedDate = Date()
    @Published var availableGuides = [Guide]()

    
}

extension TrailBookingPresenter {

    private func setTotalPriceString() {
        let totalPrice = Double(selectedPax * pricePerPax)
        totalPriceString = "$" + String(format: "%.2f", totalPrice)
    }

    private func filterAvailableGuides() {
        availableGuides = originalGuides.filter { guide in
            if let unavailableDates = guide.unavailableDates {
                if unavailableDates.contains(selectedDate) {
                    return false
                }
            }

            guard let dayOfWeek = selectedDate.dayOfWeek() else {
                ChalloLogger.logger.fault("Unable to get the day of week of selected booking date")
                return false
            }
            
            return guide.daysAvailable.contains(dayOfWeek)
        }
    }
}
