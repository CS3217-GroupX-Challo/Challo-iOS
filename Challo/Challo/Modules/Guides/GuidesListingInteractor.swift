//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

class GuidesListingInteractor: InteractorProtocol, GuideAPIInteractor {
    typealias JSON = AlamofireManager.JSON
    typealias HEADER = AlamofireManager.HEADER
    weak var presenter: GuidesListingPresenter!
    
    private let api = AlamofireManager.alamofireManager
    private let guidesAPI = "/guide"
    private let areasAPI = "/area" // To be ported over to AreaListingInteractor
    
    func getGuides() {
        api.get(url: guidesAPI,
                headers: HEADER()) { response, error in
            if error != nil {
                return
            }
            
            self.presenter.guides = self.parseGuides(response: response)
            self.presenter.originalGuides = self.presenter.guides
        }
    }
    
    // location options for filtering location
    // varies based on the various locations of guides
    // that are onboard the system
    func getLocationOptions() {
        api.get(url: areasAPI,
                headers: HEADER()) { response, error in
            if error != nil {
                return
            }
            let areas = self.parseAreas(response: response)
            self.presenter.filterTypes.locations
                = self.convertAreasToLocationOptions(areas: areas)
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
