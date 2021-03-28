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

    var pricePerPaxString: String = "$25"
    @Published var totalPriceString: String = "$0.00"
    @Published var selectedPax: Int = 0 {
        didSet {
            setTotalPriceString()
        }
    }
    @Published var paxRange = [1, 2, 3, 4, 5]
    @Published var selectedDate = Date()
}

extension TrailBookingPresenter {

    private func setTotalPriceString() {
        let totalPrice = Double(selectedPax * pricePerPax)
        totalPriceString = "$" + String(format: "%.2f", totalPrice)
    }
}
