//
//  DashboardProfileImage.swift
//  Challo
//
//  Created by Shao Yi on 13/4/21.
//

import SwiftUI

struct DashboardProfileImage<Provider: ProfileImageProvider>: View {

    var presenter: Provider

    var body: some View {
        Group {
             if presenter.profileImgPath.isEmpty {
                Image("avatar-image").resizable()
            } else {
                ImageService.loadImage(path: presenter.profileImgPath, width: 150, height: 150)
            }
        }.scaledToFit()
        .clipShape(Circle())
    }
}
