//
//  ChatService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Foundation

/// Facade class for chat functionality
///
/// `ChatService`primarily routes operations to their respective handlers
protocol ChatService: ChatDialogService, ChatAuthService {
    var isConnected: Bool { get }
    var isConnecting: Bool { get }
}
