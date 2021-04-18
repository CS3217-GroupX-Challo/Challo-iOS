//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import Foundation

class GuidesListingInteractor: EntityListingInteractor {

    weak var presenter: GuidesListingPresenter!
    
    let guideRepository: GuideRepositoryProtocol
    
    init(guideRepository: GuideRepositoryProtocol) {
        self.guideRepository = guideRepository
    }
    
    func getAllEntities() {
        guideRepository.fetchGuidesAndRefresh(didRefresh: presenter.didPopulateGuides)
    }

    func getCachedEntities() -> [Guide] {
        guideRepository.getAll()
    }
}
