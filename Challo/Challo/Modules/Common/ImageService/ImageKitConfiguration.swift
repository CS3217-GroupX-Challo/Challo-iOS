//
//  ImageKitConfiguration.swift
//  Challo
//
//  Created by Shao Yi on 10/4/21.
//

import ImageKitIO

struct ImageKitConfiguration: ThirdPartyAPIConfiguration {
    static func initConfiguration() {
        let _ = ImageKit.init(publicKey: "public_SHddXLhWEXk3EMUTHlqpFPy0lvw=",
                               urlEndpoint: "https://ik.imagekit.io/challocs3217",
                               transformationPosition: .PATH)
        ChalloLogger.logger.info("ImageKit has been initialised!")
    }
    
}
