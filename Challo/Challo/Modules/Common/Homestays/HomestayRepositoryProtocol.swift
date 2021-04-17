//
//  HomestayRepositoryProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation

protocol HomestayRepositoryProtocol: Repository<UUID, Homestay> {
    func fetchHomestaysAndRefresh(didRefresh: (([Homestay]) -> Void)?)
}
