//
//  TrailBookingPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

class TrailBookingPresenter: PresenterProtocol, AlertPresenter {

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

    @Published var selectedDate: Date? {
        didSet {
            availableGuides = interactor.filterAvailableGuides(selectedDate: selectedDate)
            selectedGuideId = nil
        }
    }
    var validDateRange: ClosedRange<Date> {
        interactor.validDateRange
    }
    @Published var excludedDates: Set<Date> = Set()

    @Published var availableGuides = [Guide]()
    @Published var selectedGuideId: UUID?

    // MARK: Alert Presenter
    @Published var isSuccessAlert: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    @Published var isLoading = true

    func populateTrailBookingPage(for trail: Trail) {
        isLoading = true
        self.trail = trail
        resetFields()
        interactor.setUp(trailId: trail.trailId) { [weak self] in
            self?.availableGuides = self?.interactor.filterAvailableGuides(selectedDate: self?.selectedDate) ?? []
            self?.excludedDates = self?.interactor.getExcludedDates() ?? Set<Date>()
            self?.isLoading = false
        }
    }

    func makeBooking() {
        let (fieldsAllValid, message) = checkAllFieldsValid()
        if !fieldsAllValid {
            presentFailureAlert(title: "Failed to make booking",
                                message: message)
            return
        }

        guard let guideId = selectedGuideId,
              let trailId = trail?.trailId,
              let selectedDate = selectedDate else {
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
                self?.presentFailureAlert(title: "Failed to make booking",
                                          message: "Oops! Something went wrong, please try again.")
                return
            }
            
            self?.presentSuccessAlert(title: "Success!",
                               message: "Your booking has been made successfully!")
        }
    }
}

extension TrailBookingPresenter {

    private func resetFields() {
        selectedPax = 0
        selectedDate = nil
        availableGuides = []
    }

    private func setTotalPriceString() {
        let totalPrice = Double(selectedPax * pricePerPax)
        totalPriceString = String(format: "%.2f", totalPrice) + " Rp"
    }

    private func checkAllFieldsValid() -> (success: Bool, message: String) {
        if selectedPax == 0 {
            return (success: false, message: "Booking must be for at least one guest!")
        }

        if selectedDate == nil {
            return (success: false, message: "Please select a date!")
        }
    
        if selectedGuideId == nil {
            return (success: false, message: "Please select a guide!")
        }
        
        return (success: true, message: "")
    }
}
