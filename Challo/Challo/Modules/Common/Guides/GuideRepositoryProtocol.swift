//
//  GuideRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

protocol GuideRepositoryProtocol: Repository<Guide> {
    func fetchGuidesAndRefresh(didRefresh: (([Guide]) -> Void)?)
}

extension GuideRepositoryProtocol {
    func fetchGuidesAndRefresh() {
        fetchGuidesAndRefresh(didRefresh: nil)
    }
}
