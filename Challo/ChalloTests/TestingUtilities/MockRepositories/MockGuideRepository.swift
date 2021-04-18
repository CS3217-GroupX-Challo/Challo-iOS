//
//  MockGuideRepository.swift
//  ChalloTests
//
//  Created by Shao Yi on 29/3/21.
//

@testable import Challo
import Foundation

class MockGuideRepository: Repository<UUID, Guide>, GuideRepositoryProtocol {

    let guideAPI: GuideAPIProtocol
    
    init() {
        self.guideAPI = MockGuideAPI()
        super.init()
        fetchGuidesAndRefresh()
    }

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
    
    func fetchGuidesAndRefresh(didRefresh: (([Guide]) -> Void)? = nil) {
        guideAPI.getGuides { [weak self] guides in
            self?.refreshGuides(guides)
            didRefresh?(guides)
        }
    }

    func initialFetch(didFetch: @escaping (([Guide]) -> Void)) {
        fetchGuidesAndRefresh(didRefresh: didFetch)
    }
}
