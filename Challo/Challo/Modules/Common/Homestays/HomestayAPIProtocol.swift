//
//  HomestayAPIProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation

protocol HomestayAPIProtocol {
    func getHomestays(callback: @escaping ([Homestay]) -> Void,
                      url: String)

    func getHomestay(homestayId: UUID,
                     callback: @escaping (Homestay?) -> Void,
                     url: String)
}
