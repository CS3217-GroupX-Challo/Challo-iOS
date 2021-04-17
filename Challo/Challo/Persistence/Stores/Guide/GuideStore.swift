//
//  GuideStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class GuideStore {
    private let guideModelConvertor: GuideModelConvertor
    private let guideRepository: GuideDetailsRepositoryProtocol
    
    init(guideModelConvertor: GuideModelConvertor,
         guideRepository: GuideDetailsRepositoryProtocol) {
        self.guideModelConvertor = guideModelConvertor
        self.guideRepository = guideRepository
    }
    
    func getAllGuides() -> [Guide] {
        let guideObjects = guideRepository.getAllGuides()
        return guideObjects.map { guideObject in
            guideModelConvertor.convertPersistenceObjectToModel(object: guideObject)
        }
    }
    
    func saveGuides(guides: [Guide]) {
        let guideObjects = guides.map { guide in
            guideModelConvertor.convertModelToPersistenceObject(model: guide)
        }
        
        guideRepository.saveGuides(guideObjects: guideObjects)
    }
}
