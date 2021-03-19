//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

class GuidesListingInteractor: InteractorProtocol, GuideAPI, AreaAPI {
    typealias JSON = AlamofireManager.JSON
    typealias HEADER = AlamofireManager.HEADER
    weak var presenter: GuidesListingPresenter!
    
    func populateGuides() {
        getGuides { [weak self] guides in
            guard let self = self else {
                return
            }
            
            self.presenter.guides = guides
            self.presenter.originalGuides = guides
        }
    }
    
    // location options for filtering location
    // varies based on the various locations of guides
    // that are onboard the system
    func getLocationOptions() {
        getAreas { [weak self] areas in
            guard let self = self else {
                return
            }
            
            let areaOptions = self.convertAreasToLocationOptions(areas: areas)
            self.presenter.filterTypes.locations = areaOptions
        }
    }
    private func convertAreasToLocationOptions(areas: [Area]) -> [String] {
        var locationOptions: [String] = ["Default"]
        for area in areas {
            locationOptions.append(area.areaName)
        }
        return locationOptions
    }
}
