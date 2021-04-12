//
//  ImageService.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import SwiftUI
import ImageKitIO
import SDWebImageSwiftUI

struct ImageService: ImageServiceProtocol {
    
    static var urlEndpoint: String {
        guard let urlEndpoint = ProcessInfo.processInfo.environment["imagekit_url_endpoint"] else {
            fatalError("ImageKit urlEndpoint is not in env var")
        }
        return urlEndpoint
    }
        
    private static func generateFullUrl(path: String, height: CGFloat, width: CGFloat) -> String {
        ImageKit.shared.url(path: path, transformationPosition: .QUERY)
            .height(height: Int(height))
            .aspectRatio(width: Int(width), height: Int(height))
            .create()
    }
    
    static func loadImage(path: String, height: CGFloat = 400, width: CGFloat = 400,
                          onSuccess: ((UIImage, Data?) -> Void)? = nil) -> Image {
        let fullUrl = generateFullUrl(path: path, height: height, width: width)
        
        let image = WebImage(url: URL(string: fullUrl))
            .onSuccess { image, data, _ in
                onSuccess?(image, data)
            }
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
        return Image(uiImage: image.asUIImage())
    }
        
    static func uploadImage(image: Data, fileName: String, onProgress: ((Progress) -> Void)?,
                            onSuccess: ((String) -> Void)?, onFailure: ((Error) -> Void)?) {
        ImageKit.shared.uploader().upload(
          file: image,
          fileName: fileName,
          useUniqueFilename: true,
          folder: "/",
          isPrivateFile: false,
          customCoordinates: "",
          responseFields: "",
          progress: { progress in
            onProgress?(progress)
          },
          completion: { result in
               switch result {
               case .success:
                onSuccess?("\(urlEndpoint)/\(fileName)")
               case .failure(let error):
                onFailure?(error)
              }
          }
        )
    }
    
}
