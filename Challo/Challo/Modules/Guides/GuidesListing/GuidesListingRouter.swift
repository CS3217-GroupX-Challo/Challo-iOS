//
//  GuidesListingRouter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

class GuidesListingRouter: RouterProtocol {
    weak var presenter: GuidesListingPresenter!
    let reviewAPI: ReviewAPIProtocol
    
    var guideProfilePresenter: GuideProfilePresenter?
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }
    
    func getGuideProfileDetailsPage(guide: Guide) -> some View {
        let presenter = GuideProfilePresenter(guide: guide, reviewAPI: reviewAPI)
        guideProfilePresenter = presenter
        return GuideProfilePage().environmentObject(presenter)
    }
    
}
