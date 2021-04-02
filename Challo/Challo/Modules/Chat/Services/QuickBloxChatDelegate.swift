//
//  QuickBloxChatDelegate.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatDelegate: NSObject {
    
    override init() {
        super.init()
        QBChat.instance.addDelegate(self)
    }
}
 
// MARK: QBChatDelegate
extension QuickBloxChatDelegate: QBChatDelegate {
    func chatDidReceive(_ message: QBChatMessage) {
        print(message)
    }
    
}
