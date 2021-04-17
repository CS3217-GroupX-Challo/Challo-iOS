//
//  DashboardProfileImage.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI

struct DashboardProfileImage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter
    
    var body: some View {
        presenter.displayedProfileImage
            .onTapGesture {
                presenter.isImagePickerOpen = true
            }.sheet(isPresented: $presenter.isImagePickerOpen, onDismiss: presenter.loadImage) {
                ImagePicker(image: $presenter.inputImage)
            }
    }
}
