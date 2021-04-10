//
//  ImageService.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI
import ImageKitIO
import SDWebImageSwiftUI

class ImageService: ImageServiceProtocol {    
    private func generateFullUrl(path: String, height: CGFloat, width: CGFloat) -> String {
        ImageKit.shared.url(path: path, transformationPosition: .QUERY)
            .height(height: Int(height))
            .aspectRatio(width: Int(width), height: Int(height))
            .create()
    }
    
    func loadImage(path: String, height: CGFloat = 400, width: CGFloat = 400,
                   onSuccess: ((UIImage, Data?) -> Void)? = nil) -> some View {
        let fullUrl = generateFullUrl(path: path, height: height, width: width)
        
        return WebImage(url: URL(string: fullUrl))
            .onSuccess { image, data, _ in
                onSuccess?(image, data)
            }
            .resizable()
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
//            .placeholder {
//                Rectangle().foregroundColor(.gray)
//            }
    }
    
//    func loadImage
    
    func uploadImage(image: NSData) -> String {
        ""
    }
    
}
