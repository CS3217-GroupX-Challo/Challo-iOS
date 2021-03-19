//
//  GuideProfilePagePresenter.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Combine

class GuideProfilePagePresenter: PresenterProtocol {
    var router: GuideProfilePageRouter?
    var interactor: GuideProfilePageInteractor!
    
    var guide: Guide
    @Published var reviews: [Review] = []
    
    init(guide: Guide) {
        self.guide = guide
    }
}
