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
    
    var body: some View {
        RefreshableScrollView(refreshing: $presenter.isRefreshing) {
            VStack(spacing: 40) {
                ForEach(0...guides.count / 2, id: \.self) { index in
                    HStack(spacing: 30) {
                        if index * 2 < guides.count {
                            GuideDetailsCard(guide: guides[index * 2],
                                             width: width / 3,
                                             presenter: presenter)
                                    .offset(x: index * 2 + 1 < guides.count || guides.count == 1 ?
                                                0 : -1 * (40 + width / 6)) // manual offset
                            if index * 2 + 1 < guides.count {
                                GuideDetailsCard(guide: guides[index * 2 + 1],
                                                 width: width / 3,
                                                 presenter: presenter)
                            }
                        }
                    }
                }
            }
        }
    }
}
