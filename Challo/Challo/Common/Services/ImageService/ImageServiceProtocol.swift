//
//  ImageServiceProtocol.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI

protocol ImageServiceProtocol {
    associatedtype SomeImage: View
    
    static func loadImage(path: String, height: CGFloat, width: CGFloat,
                          onSuccess: ((UIImage, Data?) -> Void)?) -> SomeImage
    static func uploadImage(image: Data, fileName: String, onProgress: ((Progress) -> Void)?,
                            onSuccess: (() -> Void)?, onFailure: ((Error) -> Void)?)
}

extension ImageServiceProtocol {
    static func loadImage(path: String, height: CGFloat = 400, width: CGFloat = 400,
                          onSuccess: ((UIImage, Data?) -> Void)? = nil) -> SomeImage {
        loadImage(path: path, height: height, width: width, onSuccess: onSuccess)
    }
    
    static func uploadImage(image: Data, fileName: String, onProgress: ((Progress) -> Void)? = nil,
                            onSuccess: (() -> Void)? = nil, onFailure: ((Error) -> Void)? = nil) {
        uploadImage(image: image, fileName: fileName, onProgress: onProgress,
                    onSuccess: onSuccess, onFailure: onFailure)
    }

}
