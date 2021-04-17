//
//  GuideOnboardingPage.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

import SwiftUI

struct GuideOnboardingPage: View {

    @ObservedObject var presenter: GuideOnboardingPresenter

    var onboardingView: some View {
        VStack(alignment: .center) {
            if !presenter.loaded {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                OnboardingForm(nickname: $presenter.nickname,
                               date: $presenter.dateOfBirth,
                               languages: $presenter.languages,
                               yearsOfExperience: $presenter.yearsOfExperience,
                               hobbies: $presenter.hobbies,
                               daysAvailable: $presenter.daysAvailable,
                               biography: $presenter.biography,
                               trails: presenter.trails.map { HashableTrailOption(trail: $0) },
                               chosenTrails: $presenter.chosenTrails,
                               onSubmit: self.presenter.submitDetails)
            }
        }
    }

    var body: some View {
        PageLayout(titleLabel: "Complete your account") { _ in
            onboardingView
        }
        .alert(isPresented: $presenter.isShowingAlert) {
            Alert(title: Text(presenter.alertTitle),
                  message: Text(presenter.alertMessage),
                  dismissButton: .default(Text("Close")))
        }
        .onAppear { presenter.loadTrailAndAreaData() }
        .ignoresSafeArea()
    }
}
