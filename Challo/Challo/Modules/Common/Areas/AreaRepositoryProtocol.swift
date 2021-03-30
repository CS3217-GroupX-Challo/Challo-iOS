//
//  AreaRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

protocol AreaRepositoryProtocol: Repository<Area> {
    func fetchAreasAndRefresh(didRefresh: (([Area]) -> Void)?)
}

extension AreaRepositoryProtocol {
    func fetchAreasAndRefresh() {
        fetchAreasAndRefresh(didRefresh: nil)
    }
}
