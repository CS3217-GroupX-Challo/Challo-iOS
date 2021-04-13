//
//  UpdateProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct UpdateProfilePage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter
    
    let maxProfileImageDiameter: CGFloat = 200
    
    func makeField(label: String, textBinding: Binding<String>, errorMessage: String) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .bold()
            TextField(presenter.name, text: textBinding)
            Divider()
                .background(presenter.errorMessage == errorMessage ? Color.red : Color.black)
            if presenter.errorMessage == errorMessage {
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
                UpdatableProfileImage()
                    .frame(maxWidth: maxProfileImageDiameter, maxHeight: maxProfileImageDiameter)
                Image(systemName: "camera.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
                    .offset(x: -20, y: -10)
                    .foregroundColor(.gray)
            }.padding(.bottom, 30)
            makeField(label: "Name", textBinding: $presenter.editName,
                      errorMessage: UpdateProfileErrorMessages.invalidNameErrorMessage)
            makeField(label: "Email", textBinding: $presenter.editEmail,
                      errorMessage: UpdateProfileErrorMessages.invalidEmailErrorMessage)
            Spacer()
        }.padding(.horizontal, 50)
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
