//
//  PriceFilterView.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct PriceFilterView<Presenter: PriceFilterableEntityListingPresenter>: View {
    
    @ObservedObject var presenter: Presenter
    @ObservedObject var slider: CustomSlider
    
    init(presenter: Presenter) {
        self.presenter = presenter
        slider = presenter.slider
    }

    var sliderLowerValue: String {
        String(format: "%.0f", floor(slider.lowHandle.currentValue))
    }
    
    var sliderUpperValue: String {
        String(format: "%.0f", ceil(slider.highHandle.currentValue))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            FilterViewUtility.makeFilterSectionTitle("Price Range")
                .padding(.vertical, 20)
            Text("$\(sliderLowerValue) - $\(sliderUpperValue)")
            CustomSliderView(slider: slider)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
        }.frame(maxWidth: .infinity)
    }
}
