//
//  TrailListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

class TrailListingInteractor: InteractorProtocol {

    private var trailAPI: TrailAPI
    weak var presenter: TrailListingPresenter!

    init(trailAPI: TrailAPI) {
        self.trailAPI = trailAPI
    }
    
    convenience init() {
        let trailAPI = TrailAPI(parser: TrailAPIParser(),
                                networkManager: APINetwork.getNetworkManager())
        self.init(trailAPI: trailAPI)
    }

    func getAllTrails(callback: @escaping ([Trail]) -> Void) {
        trailAPI.getAllTrails(callback: callback)
    }
}
