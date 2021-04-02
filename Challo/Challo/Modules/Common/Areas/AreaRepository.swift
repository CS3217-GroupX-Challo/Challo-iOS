//
//  AreaRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

class AreaRepository: Repository<UUID, Area>, AreaRepositoryProtocol {
    let areaAPI: AreaAPIProtocol
    
    init(areaAPI: AreaAPIProtocol) {
        self.areaAPI = areaAPI
        super.init()
        fetchAreasAndRefresh()
    }
    
    private func refreshAreas(_ areas: [Area]) {
        for area in areas {
            upsert(entity: area, key: area.areaId)
        }
    }
    
    func fetchAreasAndRefresh(didRefresh: (([Area]) -> Void)?) {
        areaAPI.getAreas { [weak self] areas in
            self?.refreshAreas(areas)
        }
    }
}
