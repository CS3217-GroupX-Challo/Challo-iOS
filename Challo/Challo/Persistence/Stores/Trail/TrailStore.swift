//
//  TrailStore.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TrailStore {
    private var repository: TrailDetailsRepositoryProtocol
    private var convertor: TrailModelConvertor
    
    init(repository: TrailDetailsRepositoryProtocol,
         convertor: TrailModelConvertor) {
        self.repository = repository
        self.convertor = convertor
    }
    
    func getAllTrails() -> [Trail] {
        let trailObjects = repository.getAllTrails()
        return trailObjects.map { trailObject in
            convertor.convertPersistenceObjectToModel(object: trailObject)
        }
    }
    
    func saveTrails(trails: [Trail]) {
        let trailObjects = trails.map { trail in
            convertor.convertModelToPersistenceObject(model: trail)
        }
        
        repository.saveTrails(trailObjects: trailObjects)
    }
}
