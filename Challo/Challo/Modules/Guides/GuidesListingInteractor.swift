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
}
