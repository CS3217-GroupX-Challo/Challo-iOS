//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import Foundation

class GuidesListingInteractor: InteractorProtocol {

    typealias JSON = NetworkManager.JSON
    typealias HEADER = NetworkManager.HEADER
    weak var presenter: GuidesListingPresenter!
    
    let guideRepository: GuideRepositoryProtocol
    
    init(guideRepository: GuideRepositoryProtocol) {
        self.guideRepository = guideRepository
    }
    
    func populateGuides() {
        guideRepository.fetchGuidesAndRefresh(didRefresh: presenter.didPopulateGuides)
    }
    
}
