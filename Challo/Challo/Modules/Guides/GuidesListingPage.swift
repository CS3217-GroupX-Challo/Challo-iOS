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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                    VStack {
                        HStack {
                            GuidesListingTitle(leading: geometry.size.width / 5)
                            Spacer()
                        }
                        RoundedTextField(placeholder: "Search here...",
                                         text: $presenter.searchKeyword,
                                         isPasswordField: false)
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height / 5,
                       alignment: .center)
                GuidesFiltersView(width: geometry.size.width / 5,
                                  presenter: presenter)
                GuidesCardListingsView(guides: guides,
                                       width: geometry.size.width)
            }
        }
        .onAppear {
            presenter.interactor.populateGuides()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
