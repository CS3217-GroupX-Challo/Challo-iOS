//
//  AreaRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol AreaRepositoryProtocol: Repository<UUID, Area> {
    func fetchAreasAndRefresh(didRefresh: (([Area]) -> Void)?)
}

extension AreaRepositoryProtocol {
    func fetchAreasAndRefresh() {
        fetchAreasAndRefresh(didRefresh: nil)
    }
}
