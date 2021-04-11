//
//  GuidesListingPage.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesListingPage: View {
    @ObservedObject var presenter: GuidesListingPresenter
    
    var guides: [Guide] {
        presenter.guides
    }
    
    var headerContent: some View {
        RoundedTextField(placeholder: "Search here...",
                         text: $presenter.searchKeyword,
                         isPasswordField: false)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Let us guide your way", headerContent: AnyView(headerContent)) { geometry in
            Group {
                if presenter.isLoading {
                    Loading(isAnimating: .constant(true), style: .large)
                } else {
                    VStack {
                        GuidesFiltersView(width: geometry.size.width / 5,
                                          presenter: presenter)
                            .padding(.top, 20)
                        GuidesCardListingsView(guides: guides,
                                               width: geometry.size.width,
                                               presenter: presenter)
                    }.padding(.bottom, 80)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onAppear {
            presenter.populateGuides()
        }
    }
}
