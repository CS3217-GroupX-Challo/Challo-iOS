//
//  GuideRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol GuideRepositoryProtocol: Repository<UUID, Guide> {
    func fetchGuidesAndRefresh(didRefresh: (([Guide]) -> Void)?)
}

extension GuideRepositoryProtocol {
    func fetchGuidesAndRefresh() {
        fetchGuidesAndRefresh(didRefresh: nil)
    }
}
