//
//  HomestayFilterView.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayFilterView: View {
    @EnvironmentObject var presenter: HomestayListingPresenter

    var body: some View {
        FilterViewUtility.makeFilterSheet {
            VStack(alignment: .leading) {
                PriceFilterView<HomestayListingPresenter>(presenter: presenter)
                Spacer()
            }.padding(.horizontal, 50)
        }
    }
}
