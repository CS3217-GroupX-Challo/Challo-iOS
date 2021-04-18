//
//  UpdateProfilePageGuide.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import SwiftUI

struct UpdateProfilePageGuide: View {
    @EnvironmentObject var presenter: GuideDashboardPresenter

    let maxProfileImageDiameter: CGFloat = 200

    var errorMessage: String {
        presenter.errorMessage ?? ""
    }

    func makeField(label: String, textBinding: Binding<String>, errorMessages: [String]) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .bold()
            TextField(presenter.name, text: textBinding)
            Divider()
                .background(errorMessages.contains(errorMessage) ? Color.red : Color.black)
            if errorMessages.contains(errorMessage) {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }.frame(maxWidth: .infinity)
        .padding(.top, 30)
    }

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                UpdatableProfileImageGuide()
                    .frame(maxWidth: maxProfileImageDiameter, maxHeight: maxProfileImageDiameter)
                Image(systemName: "camera.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
                    .offset(x: -20, y: -10)
                    .foregroundColor(.gray)
            }.padding(.bottom, 30)
            makeField(label: "Name", textBinding: $presenter.editName,
                      errorMessages: [UpdateProfileErrorMessages.invalidNameErrorMessage])
            makeField(label: "Email", textBinding: $presenter.editEmail,
                      errorMessages: [
                        UpdateProfileErrorMessages.invalidEmailErrorMessage,
                        UpdateProfileErrorMessages.emailAlreadyTakenErrorMessage
                      ])
            Spacer()
        }.padding(.horizontal, 50)
        .onAppear(perform: presenter.onOpenUpdateProfilePage)
        .navigationBarItems(trailing:
                                Button(action: presenter.onTapSave) {
                                    if presenter.isSaving {
                                        Spinner(diameter: 30)
                                    } else {
                                        Text("Save")
                                            .foregroundColor(presenter.isUpdateSaveButtonDisabled
                                                                ? .gray
                                                                : .themeTertiary)
                                            .disabled(presenter.isUpdateSaveButtonDisabled)
                                    }
                                }
        )
        .alert(isPresented: $presenter.isShowingUpdateAlert) {
            Alert(title: Text(presenter.alertMessageTitle),
                  message: Text(presenter.alertMessageDescription),
                  dismissButton: .default(Text("Close"), action: presenter.onCloseAlert))
        }
    }
}
