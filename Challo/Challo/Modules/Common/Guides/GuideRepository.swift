//
//  GuideRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

class GuideRepository: Repository<UUID, Guide>, GuideRepositoryProtocol, LocalStorageRetriever {

    typealias Model = Guide
    typealias LocalStore = GuideStore

    let guideAPI: GuideAPIProtocol
    let localStore: GuideStore
    var isInitialized: Bool = false
    
    init(guideAPI: GuideAPIProtocol,
         guideStore: GuideStore) {
        self.guideAPI = guideAPI
        self.localStore = guideStore
        super.init()
    }
    
    private func refreshGuides(_ guides: [Guide]) {
        for guide in guides {
            upsert(entity: guide, key: guide.userId)
        }
    }
    
    func fetchGuidesAndRefresh(didRefresh: (([Guide]) -> Void)? = nil) {
        guideAPI.getGuides { [weak self] guides in
            self?.refreshGuides(guides)
            self?.saveToLocalStore(models: guides)
            didRefresh?(guides)
        }
    }

    func initialFetch(didFetch: (() -> Void)?) {
        if isInitialized {
            didFetch?()
            return
        }
        fetchGuidesAndRefresh { guides in
            self.isInitialized = true

            if guides.isEmpty {
                let localGuides = self.retrieveFromLocalStore()
                self.refreshGuides(localGuides)
                didFetch?()
                return
            }
            
            didFetch?()
        }
    }
    
    func fetchAllAndRefresh(didRefresh: (() -> Void)?) {
        fetchGuidesAndRefresh(didRefresh: { _ in didRefresh?() })
    }
}
