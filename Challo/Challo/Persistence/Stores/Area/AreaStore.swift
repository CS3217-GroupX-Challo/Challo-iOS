//
//  AreaStore.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

class AreaStore {
    private let areaRepository: AreaDetailsRepositoryProtocol
    private let convertor: AreaModelConvertor
    
    init(areaRepository: AreaDetailsRepositoryProtocol,
         convertor: AreaModelConvertor) {
        self.areaRepository = areaRepository
        self.convertor = convertor
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
