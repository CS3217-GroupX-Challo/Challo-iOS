//
//  AreaRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

protocol AreaRepositoryProtocol: Repository<Area> {
    func fetchAreassAndRefresh()
}

class AreaRepository: Repository<Area>, AreaRepositoryProtocol {
    let areaAPI: AreaAPIProtocol
    
    init(areaAPI: AreaAPIProtocol) {
        self.areaAPI = areaAPI
        super.init()
        fetchAreassAndRefresh()
    }
    
    private func refreshAreas(_ areas: [Area]) {
        for area in areas {
            upsert(entity: area, key: area.areaId)
        }
    }
    
    func fetchAreassAndRefresh() {
        areaAPI.getAreas { [weak self] areas in
            self?.refreshAreas(areas)
        }
    }
}
