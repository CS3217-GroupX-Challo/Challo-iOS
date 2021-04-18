//
//  ImageLoader.swift
//  Challo
//
//  Created by Shao Yi on 14/4/21.
//

import SwiftUI

struct ImageLoader: View {
    let profileImg: String?
    var width: CGFloat = 300
    var height: CGFloat = 300
    var defaultImage: String
    
    var body: some View {
        if let path = profileImg {
            ImageService.loadImage(path: path, width: width, height: height)
        } else {
            Image(defaultImage)
                .resizable()
        }
    }
}
