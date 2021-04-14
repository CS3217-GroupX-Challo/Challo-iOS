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
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }
    
    func getGuideProfileDetailsPage(guide: Guide) -> some View {
//        NavigationLink(destination: GuideProfilePage(presenter: GuideProfilePresenter(guide: guide,
//                                                                                      reviewAPI: reviewAPI))) {
            Image(systemName: "ellipsis")
                .padding()
                .frame(width: 100)
                .onTapGesture { [weak self] in
                    self?.presenter.isSelectedGuideSheetOpen = true
                    self?.presenter.selectedGuide = guide
                }
//        }
    }
}
