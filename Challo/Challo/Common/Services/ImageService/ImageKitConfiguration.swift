//
//  ImageKitConfiguration.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import ImageKitIO

struct ImageKitConfiguration: ThirdPartyAPIConfiguration {
    static func initConfiguration() {
        guard let publicKey = ProcessInfo.processInfo.environment["imagekit_public_key"] else {
            fatalError("ImageKit publicKey is not in env var")
        }
        
        guard let urlEndpoint = ProcessInfo.processInfo.environment["imagekit_url_endpoint"] else {
            fatalError("ImageKit urlEndpoint is not in env var")
        }
        
        guard let apiPath = ProcessInfo.processInfo.environment["api_path"] else {
            fatalError("api_path is not in env var")
        }
        
        _ = ImageKit(publicKey: publicKey,
                     urlEndpoint: urlEndpoint,
                     transformationPosition: .PATH,
                     authenticationEndpoint: "\(apiPath)/imageKitAUth")
        ChalloLogger.logger.info("ImageKit has been initialised!")
    }
    
}
