//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

class GuidesListingInteractor: InteractorProtocol, GuideAPIInteractor, TrailsAPIInteractor {
    typealias JSON = AlamofireManager.JSON
    typealias HEADER = AlamofireManager.HEADER
    weak var presenter: GuidesListingPresenter!
    
    private let api = AlamofireManager.alamofireManager
    private let guidesAPI = "/guide"
    private let guidesTrailAPI = "/guide/trail/"
    private let areasAPI = "/area" // To be ported over to AreaListingInteractor
    
    func getGuides() {
        api.get(url: guidesAPI,
                headers: HEADER()) { response, error in
            if error != nil {
                return
            }
            
            let guides = self.parseGuides(response: response)
            var updatedGuidesWithTrail: [Guide] = []
            for var guide in guides {
                self.api.get(url: self.guidesTrailAPI + guide.userId.uuidString,
                             headers: HEADER()) { response, error in
                    if error != nil {
                        return
                    }
                    guide.trails = self.parseTrail(response: response)
                    print(guide.trails)
                    updatedGuidesWithTrail.append(guide)
                    self.presenter.guides = updatedGuidesWithTrail
                    self.presenter.originalGuides = updatedGuidesWithTrail
                }
            }
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
