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
            guideModelConvertor.convertGuidePersistenceObject(guideObject: guideObject)
        }
    }
    
    func saveGuides(guides: [Guide]) -> GuidePersistenceObject {
        let guideObjects = guides.map { guide in
            guideModelConvertor.convertGuideToGuidePersistenceObject(guide: guide)
        }
        
        guideRepository.saveGuides(guideObjects: guideObjects)
    }
}
