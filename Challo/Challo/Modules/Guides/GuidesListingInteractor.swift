//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

class GuidesListingInteractor: InteractorProtocol {
    typealias JSON = AlamofireManager.JSON
    weak var presenter: GuidesListingPresenter!
    
    private let api = AlamofireManager.alamofireManager
    private let guidesAPI = "/api/guide"
}
