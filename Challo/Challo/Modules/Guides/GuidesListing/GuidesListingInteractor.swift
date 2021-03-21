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
    
    var guideAPI: GuideAPI
    var areaAPI: AreaAPI
    
    // Dependency injection
    init(guideAPI: GuideAPI, areaAPI: AreaAPI) {
        self.guideAPI = guideAPI
        self.areaAPI = areaAPI
    }
    
    func populateGuides() {
        guideAPI.getGuides { [weak self] guides in
            guard let self = self else {
                return
            }
            
            self.presenter.guides = guides
            self.presenter.originalGuides = guides
        }
    }
    
}
