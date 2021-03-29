//
//  GuideRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

protocol GuideRepositoryProtocol: Repository<Guide> {
    func fetchGuidesAndRefresh()
}

class GuideRepository: Repository<Guide>, GuideRepositoryProtocol {
    let guideAPI: GuideAPIProtocol
    
    init(guideAPI: GuideAPIProtocol) {
        self.guideAPI = guideAPI
        super.init()
        fetchGuidesAndRefresh()
    }
    
    private func refreshGuides(_ guides: [Guide]) {
        for guide in guides {
            upsert(entity: guide, key: guide.userId)
        }
    }
    
    func fetchGuidesAndRefresh() {
        guideAPI.getGuides { [weak self] guides in
            self?.refreshGuides(guides)
        }
    }
}
