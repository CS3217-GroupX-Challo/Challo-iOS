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
        presenter.displayedGuides
    }
    
    var body: some View {
        PageLayout(titleLabel: "Let us guide your way") { geometry in
            Group {
                VStack {
                    SearchBar<GuidesListingPresenter>(searchBarSheet:
                                                        AnyView(GuidesFiltersView(width: geometry.size.width / 5,
                                                                                  presenter: presenter)))
                        .environmentObject(presenter)
                    if presenter.isLoading {
                        Loading(isAnimating: .constant(true), style: .large)
                    }
                    GuidesCardListingsView(guides: guides,
                                           width: geometry.size.width,
                                           presenter: presenter)
                }.padding(.bottom, 80)
                .sheet(isPresented: $presenter.isSelectedGuideSheetOpen) {
                    if let guide = presenter.selectedGuide {
                        presenter.getGuideProfileDetailsPage(guide: guide)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onAppear {
            presenter.onAppear()
        }
    }
}
