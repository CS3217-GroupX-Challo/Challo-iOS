//
//  TrailBookingPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

class TrailBookingPresenter: PresenterProtocol {

    var interactor: TrailBookingInteractor!
    var router: TrailBookingRouter?

    private var trail: Trail?
    private var pricePerPax: Int {
        (trail?.lowestFee) ?? 25
    }

    var pricePerPaxString: String {
        String(pricePerPax) + " Rp"
    }
    @Published var totalPriceString: String = "0.00 Rp"
    @Published var selectedPax: Int = 0 {
        didSet {
            setTotalPriceString()
        }
    }
    @Published var paxRange = [1, 2, 3, 4, 5]

    @Published var selectedDate = Date() {
        didSet {
            filterAvailableGuides()
            selectedGuideId = nil
        }
    }
    var validDateRange: ClosedRange<Date> {
        let today = Date()
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? today
        let sixMonthsLater = Calendar.current.date(byAdding: .month, value: 6, to: nextDay) ?? today
        return nextDay...sixMonthsLater
    }

    private var originalGuides = [Guide]()
    @Published var availableGuides = [Guide]()
    @Published var selectedGuideId: UUID?

    @Published var isShowingBookingStatusAlert = false
    @Published var bookingStatusTitle = ""
    @Published var bookingStatusMessage = ""
    @Published var isSuccessAlert = false

    func populateTrailBookingPage(for trail: Trail) {
        self.trail = trail
        resetFields()
        interactor.getGuidesForTrail(trailId: trail.trailId) { [weak self] guides in
            self?.originalGuides = guides
            self?.filterAvailableGuides()
        }
    }

    func makeBooking() {
        let (fieldsAllValid, message) = checkAllFieldsValid()
        if !fieldsAllValid {
            failureAlert(message: message)
        }

        guard let guideId = selectedGuideId,
              let trailId = trail?.trailId else {
            return
        }
        let form = TrailBookingForm(guideId: guideId,
                                    trailId: trailId,
                                    date: selectedDate,
                                    numberOfPax: selectedPax,
                                    totalFee: Double(pricePerPax * selectedPax))

        interactor.makeBooking(bookingForm: form) { [weak self] success, err in
            if let error = err,
               !success {
                ChalloLogger.logger.log("Failed to make booking: \(error.localizedDescription)")
                self?.failureAlert(message: "Oops! Something went wrong, please try again.")
                return
            }
            
            self?.successAlert(message: "Your booking has been made successfully!")
        }
    }

    private func failureAlert(message: String) {
        self.isSuccessAlert = false
        self.bookingStatusMessage = message
        self.bookingStatusTitle = "Failed to make booking"
        self.isShowingBookingStatusAlert = true
    }

    private func successAlert(message: String) {
        self.isSuccessAlert = true
        self.bookingStatusMessage = message
        self.bookingStatusTitle = "Booking Submitted"
        self.isShowingBookingStatusAlert = true
    }
}

extension TrailBookingPresenter {

    private func resetFields() {
        selectedPax = 0
        selectedDate = Date()
        availableGuides = []
    }

    private func setTotalPriceString() {
        let totalPrice = Double(selectedPax * pricePerPax)
        totalPriceString = String(format: "%.2f", totalPrice) + " Rp"
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

    private func checkAllFieldsValid() -> (success: Bool, message: String) {
        if selectedPax == 0 {
            return (success: false, message: "Booking must be for at least one guest!")
        }
        
        if selectedGuideId == nil {
            return (success: false, message: "Please select a guide!")
        }
        
        return (success: true, message: "")
    }
}
