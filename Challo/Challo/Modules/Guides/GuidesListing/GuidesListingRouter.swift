//
//  GuidesListingRouter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

class GuidesListingRouter: RouterProtocol {
    weak var presenter: GuidesListingPresenter!
    
    func getGuideProfileDetailsPage(guide: Guide) -> some View {
        NavigationLink(destination: GuideProfilePage(presenter: GuideProfilePagePresenter(guide: guide))) {
            Text("More info")
                .foregroundColor(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.themeTertiary))
        }
    }
}
