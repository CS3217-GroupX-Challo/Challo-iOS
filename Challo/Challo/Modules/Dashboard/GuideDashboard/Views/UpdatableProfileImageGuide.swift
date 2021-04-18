//
//  UpdatableProfileImageGuide.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import SwiftUI

struct UpdatableProfileImageGuide: View {
    @EnvironmentObject var presenter: GuideDashboardPresenter

    var body: some View {
        Group {
            if let newProfileImg = presenter.image {
                newProfileImg.resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } else {
                DashboardProfileImage<GuideDashboardPresenter>()
            }
        }.onTapGesture {
            presenter.isImagePickerOpen = true
        }.sheet(isPresented: $presenter.isImagePickerOpen, onDismiss: presenter.loadImage) {
            ImagePicker(image: $presenter.inputImage)
        }
    }
}
