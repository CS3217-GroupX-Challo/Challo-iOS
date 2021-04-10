//
//  ImageServiceProtocol.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI

protocol ImageServiceProtocol {
    associatedtype SomeImage: View
    
    func loadImage(path: String, height: CGFloat, width: CGFloat, onSuccess: ((UIImage, Data?) -> Void)?) -> SomeImage
    func uploadImage(image: NSData) -> String
}

extension ImageServiceProtocol {
    func loadImage(path: String, height: CGFloat = 400, width: CGFloat = 400,
                   onSuccess: ((UIImage, Data?) -> Void)? = nil) -> SomeImage {
        loadImage(path: path, height: height, width: width, onSuccess: onSuccess)
    }
}
