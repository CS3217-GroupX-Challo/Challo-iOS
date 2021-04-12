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
    
    func makeField(label: String, textBinding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .bold()
            TextField(presenter.name, text: textBinding)
            Divider()
        }.frame(maxWidth: .infinity)
        .padding(.top, 30)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                DashboardProfileImage()
                    .clipShape(Circle())
                    .frame(maxWidth: maxProfileImageDiameter, maxHeight: maxProfileImageDiameter)
                Image(systemName: "camera.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
                    .offset(x: -20, y: -10)
                    .foregroundColor(.gray)
            }.padding(.bottom, 30)
            makeField(label: "Name", textBinding: $presenter.editName)
            makeField(label: "Email", textBinding: $presenter.editEmail)
            Spacer()
        }.padding(.horizontal, 50)
        .navigationBarItems(trailing:
                                Button(action: presenter.onTapSave) {
                                    if presenter.isSaving {
                                        Spinner(diameter: 20)
                                    } else {
                                        Text("Save")
                                            .foregroundColor(.themeTertiary)
                                    }
                                }
        )
    }
}
