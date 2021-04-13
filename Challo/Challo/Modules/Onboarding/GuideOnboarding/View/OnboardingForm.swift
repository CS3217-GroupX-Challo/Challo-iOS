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

    var body: some View {
        ScrollView {
            form
        }
    }

    var form: some View {
        VStack {
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
}

struct OnboardingForm_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingForm(
            nickname: .constant("Nickname"),
            date: .constant(Date()),
            languages: .constant(Set()),
            yearsOfExperience: .constant("0"),
            hobbies: .constant("Hobbies"),
            daysAvailable: .constant(Set())
        )
    }
}
