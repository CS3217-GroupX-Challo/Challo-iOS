//
//  HostAPIProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation

protocol HostAPIProtocol {
    func getHost(userId: UUID, callback: @escaping (Host?) -> Void)
}
