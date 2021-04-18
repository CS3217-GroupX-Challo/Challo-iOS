//
//  GuidesCardListingsView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesCardListingsView: View {
    var guides: [Guide]
    var width: CGFloat
    @ObservedObject var presenter: GuidesListingPresenter
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        RefreshableScrollView(refreshing: $presenter.isRefreshing) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(guides.indices, id: \.self) { index in
                    GuideDetailsCard(guide: guides[index],
                                     width: width / 3,
                                     presenter: presenter)
                }
            }.padding(.top, 5)
        }
    }
}
