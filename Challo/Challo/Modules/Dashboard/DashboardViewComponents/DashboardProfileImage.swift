//
//  DashboardProfileImage.swift
//  Challo
//
//  Created by Shao Yi on 13/4/21.
//

import SwiftUI

struct DashboardProfileImage<Provider: ProfileImageProvider>: View {
    @EnvironmentObject var presenter: Provider

    var body: some View {
        Group {
             if presenter.profileImgPath.isEmpty {
                Image("avatar-image").resizable()
            } else {
                ImageService.loadImage(path: presenter.profileImgPath, width: 100, height: 100)
            }
        }.scaledToFit()
        .clipShape(Circle())
    }
}
