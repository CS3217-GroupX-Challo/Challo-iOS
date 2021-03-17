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
    
    @Published var searchKeyword: String = "" {
        didSet {
            filterBySearchKeyword()
        }
    }
    @Published var guides: [Guide] = []
    var originalGuides: [Guide] = []
    
    func filterBySearchKeyword() {
        if searchKeyword.isEmpty {
            guides = originalGuides
            return
        }
        
        guides = guides.filter { guide in
            guide.name?.lowercased().contains(searchKeyword.lowercased())
                ?? false
        }
    }
}
