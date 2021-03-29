//
//  MockGuideRepository.swift
//  ChalloTests
//
//  Created by Shao Yi on 29/3/21.
//

@testable import Challo

class MockGuideRepository: Repository<Guide>, GuideRepositoryProtocol {
    let guideAPI = MockGuideAPI()
    
    init() {
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
