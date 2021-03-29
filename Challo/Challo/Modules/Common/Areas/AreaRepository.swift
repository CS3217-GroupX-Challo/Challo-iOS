//
//  AreaRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

class AreaRepository: Repository<Area> {
    let areaAPI = AreaAPI()
    
    private func refreshAreas(_ areas: [Area]) {
        for area in areas {
            upsert(entity: area, key: area.areaId)
        }
    }
    
    func fetchTrailsAndRefresh() {
        areaAPI.getAreas { [weak self] areas in
            self?.refreshAreas(areas)
        }
    }
}

