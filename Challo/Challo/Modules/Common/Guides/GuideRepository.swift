//
//  GuideRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

class GuideRepository: Repository<Guide> {
    let guideAPI: GuideAPIProtocol
    
    init(guideAPI: GuideAPIProtocol) {
        self.guideAPI = guideAPI
    }
    
    private func refreshGuides(_ guides: [Guide]) {
        for guide in guides {
            upsert(entity: guide, key: guide.userId)
        }
    }
    
    func fetchTrailsAndRefresh() {
        guideAPI.getGuides { [weak self] guides in
            self?.refreshGuides(guides)
        }
    }
}
