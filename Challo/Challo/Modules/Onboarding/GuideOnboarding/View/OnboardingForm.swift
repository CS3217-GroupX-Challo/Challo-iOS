//
//  OnboardingForm.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

import SwiftUI
import Combine

struct OnboardingForm: View {

    @Binding var nickname: String
    @Binding var date: Date
    @Binding var languages: Set<Languages>
    @Binding var yearsOfExperience: String
    @Binding var hobbies: String
    @Binding var daysAvailable: Set<Days>
    @Binding var biography: String

    var trails: [HashableTrailOption]
    @Binding var chosenTrails: Set<HashableTrailOption>

    var body: some View {
        ScrollView {
            form
        }
    }

    var form: some View {
        VStack(spacing: 0) {
            RoundedTextField(placeholder: "Nickname",
                             text: $nickname,
                             isPasswordField: false)
            dobField.padding()
            languageField.padding()
            yearsOfExperienceField
            RoundedTextField(placeholder: "Hobbies",
                             text: $hobbies,
                             isPasswordField: false)
            daysAvailableField.padding()
            biographyField.padding()
                .frame(height: 200)
            trailsField.padding()
        }
    }

    var dobField: some View {
        DatePicker("Date of birth",
                   selection: $date,
                   in: ...Date(),
                   displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.themeTertiary, lineWidth: 2)
            )
    }

    var languageField: some View {
        MultiSelectorPicker(label: Text("Languages"),
                            options: Languages.allCases,
                            optionToString: { $0.id },
                            selected: $languages)
    }

    var yearsOfExperienceField: some View {
        HStack {
            Text("Years of Experience:")
                .padding(.leading)
            RoundedTextField(placeholder: "",
                             text: $yearsOfExperience,
                             isPasswordField: false)
                .keyboardType(.numberPad)
                .onReceive(Just(yearsOfExperience)) { input in
                    yearsOfExperience = input.filter { "0123456789".contains($0) }
                }
        }
    }

    var daysAvailableField: some View {
        MultiSelectorPicker(label: Text("Available days"),
                            options: Days.allCases,
                            optionToString: { $0.rawValue },
                            selected: $daysAvailable)
    }

    var biographyField: some View {
        VStack(alignment: .leading) {
            Text("Biography:")
                .padding(.leading)
            TextEditor(text: $biography)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.themeTertiary, lineWidth: 2.0)
            )
        }
    }

    var trailsField: some View {
        MultiSelectorPicker(label: Text("Choose your trails"),
                            options: trails,
                            optionToString: { $0.name },
                            selected: $chosenTrails)
    }
}
