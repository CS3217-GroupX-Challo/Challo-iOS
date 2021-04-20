//
//  UpdatableProfileImage.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI

struct UpdatableProfileImage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter
    
    var body: some View {
        Group {
            if let newProfileImg = presenter.image {
                newProfileImg.resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } else {
                DashboardProfileImage(presenter: presenter)
            }
        }.onTapGesture {
            presenter.isImagePickerOpen = true
        }.sheet(isPresented: $presenter.isImagePickerOpen, onDismiss: presenter.loadImage) {
            ImagePicker(image: $presenter.inputImage)
        }
    }
}
