//
//  TrailStore.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TrailStore {
    private var repository: TrailDetailsRepositoryProtocol
    private var convertor = TrailModelConvertor(convertor: AreaModelConvertor())
    
    init(repository: TrailDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllTrails() -> [Trail] {
        let trailObjects = repository.getAllTrails()
        return trailObjects.map { trailObject in
            convertor.convertTrailPersistenceObjectToTrail(trailObject: trailObject)
        }
    }
    
    func saveTrails(trails: [Trail]) {
        let trailObjects = trails.map { trail in
            convertor.convertTrailToTrailPersistenceObject(trail: trail)
        }
        
        repository.saveTrails(trailObjects: trailObjects)
    }
}
