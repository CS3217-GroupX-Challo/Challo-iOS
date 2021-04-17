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

    @State var chosen = Set<Days>()
    var onSubmit: () -> Void

    var body: some View {
        Group {
            
        }
        Form {
            Section(header: Text("Enter your basic details")) {
                RoundedTextField(placeholder: "Nickname",
                                 text: $nickname)
                dobField
                languageField
                yearsOfExperienceField
                daysAvailableField
            }
            
            Section(header: Text("Let tourists know more about you")) {
                biographyField
                RoundedTextField(placeholder: "Hobbies",
                                 text: $hobbies)
            }
            
            Section(header: Text("Which trails can you guide?")) {
                trailsField
            }
            
            HStack {
                Spacer()
                
                Button(action: onSubmit, label: {
                    Text("Submit details")
                })
                .buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeSecondary))
                
                Spacer()
            }
        }
    }

    var dobField: some View {
        DatePicker("Date of birth",
                   selection: $date,
                   in: ...Date(),
                   displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
            .padding()
    }

    var languageField: some View {
        MultiSelectorPicker(label: Text("Languages"),
                            options: Languages.allCases,
                            optionToString: { $0.id },
                            selected: $languages)
            .padding()
    }

    var yearsOfExperienceField: some View {
        HStack {
            Text("Years of Experience:")
                .padding(.leading)
            RoundedTextField(placeholder: "",
                             text: $yearsOfExperience,
                             isPasswordField: false)
        }
    }

    var daysAvailableField: some View {
        MultiSelectorPicker(label: Text("Available days"),
                            options: Days.allCases,
                            optionToString: { $0.rawValue },
                            selected: $daysAvailable)
            .padding()
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
        .padding()
    }

    var trailsField: some View {
        MultiSelectorPicker(label: Text("Choose your trails"),
                            options: trails,
                            optionToString: { $0.name },
                            selected: $chosenTrails)
            .padding()
    }
}
