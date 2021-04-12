//
//  QuickBloxConfiguration.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

struct QuickBloxConfiguration: ThirdPartyAPIConfiguration {
    static func initConfiguration() {
        setCredentials()
        setLogging()
        setAutoReconnect()
        ChalloLogger.logger.info("Quickblox has been initialised!")
    }
    
    private static func setAutoReconnect() {
        QBSettings.autoReconnectEnabled = true
    }
    
    private static func setCredentials() {
        guard let applicationID = UInt(ProcessInfo.processInfo.environment["quickblox_app_id"] ?? "") else {
            fatalError("Failed to parse Quickblox applicationID from environment vars")
        }
        
        QBSettings.applicationID = applicationID
        QBSettings.authKey = ProcessInfo.processInfo.environment["quickblox_auth_key"]
        QBSettings.authSecret = ProcessInfo.processInfo.environment["quickblox_auth_secret"]
        QBSettings.accountKey = ProcessInfo.processInfo.environment["quickblox_acct_cred"]
    }
    
    private static func setLogging() {
        #if DEBUG
            QBSettings.enableXMPPLogging()
        #else
            QBSettings.disableXMPPLogging()
        #endif
    }
}
