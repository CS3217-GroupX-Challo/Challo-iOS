//
//  GuideOnboardingPage.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

import SwiftUI

struct GuideOnboardingPage: View {

    @ObservedObject var presenter: GuideOnboardingPresenter

    var body: some View {
        LoginRegisterBackground {
            Card {
                OnboardingForm(nickname: $presenter.nickname,
                               date: $presenter.dateOfBirth,
                               languages: $presenter.languages,
                               yearsOfExperience: $presenter.yearsOfExperience,
                               hobbies: $presenter.hobbies,
                               daysAvailable: $presenter.daysAvailable,
                               biography: $presenter.biography,
                               trails: presenter.trails.map { HashableTrailOption(trail: $0) },
                               chosenTrails: $presenter.chosenTrails)

                Button(action: presenter.submitDetails, label: {
                    Text("Submit details")
                })
                .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
            }
            .alert(isPresented: $presenter.isShowingAlert) {
                Alert(title: Text(presenter.alertTitle),
                      message: Text(presenter.alertMessage),
                      dismissButton: .default(Text("Close")))
            }
        }
    }
}
