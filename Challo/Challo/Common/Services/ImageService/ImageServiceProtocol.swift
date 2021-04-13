//
//  ImageServiceProtocol.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI

protocol ImageServiceProtocol {
    associatedtype SomeImage: View
    
    static func loadImage(path: String, width: CGFloat, height: CGFloat,
                          onSuccess: ((UIImage, Data?) -> Void)?) -> SomeImage
    static func uploadImage(image: Data, fileName: String, onProgress: ((Progress) -> Void)?,
                            onSuccess: ((String) -> Void)?, onFailure: ((Error) -> Void)?)
}

extension ImageServiceProtocol {
    static func loadImage(path: String, width: CGFloat = 400, height: CGFloat = 400,
                          onSuccess: ((UIImage, Data?) -> Void)? = nil) -> SomeImage {
        loadImage(path: path, width: width, height: height, onSuccess: onSuccess)
    }
    
    static func uploadImage(image: Data, fileName: String, onProgress: ((Progress) -> Void)? = nil,
                            onSuccess: ((String) -> Void)? = nil, onFailure: ((Error) -> Void)? = nil) {
        uploadImage(image: image, fileName: fileName, onProgress: onProgress,
                    onSuccess: onSuccess, onFailure: onFailure)
    }

}
