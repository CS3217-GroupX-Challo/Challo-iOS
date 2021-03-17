//
//  GuidesListingPresenter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import Combine

class GuidesListingPresenter: PresenterProtocol {
    var router: GuidesListingRouter?
    var interactor: GuidesListingInteractor!
    
    @Published var guides: [Guide] = []
}
