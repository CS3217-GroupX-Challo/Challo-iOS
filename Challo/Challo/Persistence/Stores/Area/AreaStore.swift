//
//  AreaStore.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

class AreaStore {
    private var areaRepository: AreaDetailsRepositoryProtocol
    private var convertor = AreaModelConvertor()
    
    init(areaRepository: AreaDetailsRepositoryProtocol) {
        self.areaRepository = areaRepository
    }
    
    func getAllAreas() -> [Area] {
        let areaObjects = areaRepository.getAllAreas()
        return areaObjects.map { areaObject in
            convertor.convertAreaPersistenceObjectToArea(areaObject: areaObject)
        }
    }
    
    func saveAreas(areas: [Area]) {
        let areaObjects = areas.map { area in
            convertor.convertAreaToAreaPersistenceObject(area: area)
        }
        
        areaRepository.saveAreas(areaObjects: areaObjects)
    }
}
