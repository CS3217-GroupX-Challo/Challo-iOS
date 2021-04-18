//
//  GuideRegisterButton.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import SwiftUI

struct GuideRegisterButton: View {

    @ObservedObject var presenter: GuideRegisterPresenter

    var body: some View {
        RegisterButton(presenter: presenter)
            .sheet(isPresented: $presenter.registrationComplete) {
                presenter.onboardingPage
            }
    }
}
