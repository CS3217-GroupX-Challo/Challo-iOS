//
//  TrailListingFilter.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct TrailListingFilter: View {
    
    @ObservedObject var presenter: TrailListingPresenter
    @ObservedObject var slider: CustomSlider
    
    init(presenter: TrailListingPresenter) {
        self.presenter = presenter
        slider = presenter.slider
    }
    
    var sliderLowerValue: String {
        String(format: "%.0f", floor(slider.lowHandle.currentValue))
    }
    
    var sliderUpperValue: String {
        String(format: "%.0f", ceil(slider.highHandle.currentValue))
    }
    
    private func makeDifficultyFilter(difficultyLabel: String, difficultyColor: Color,
                                      isChecked: Binding<Bool>) -> some View {
        FilterViewUtility.makeCheckBoxFilter(isChecked: isChecked) {
            Text(difficultyLabel)
                .foregroundColor(difficultyColor)
        }
    }
    
    private var difficultyFilters: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading) {
                FilterViewUtility.makeFilterSectionTitle("Difficulty")
                Text("Trails are ranked a difficulty according to their terrain, distance & elevation.")
                    .foregroundColor(Color.gray)
            }.padding(.vertical, 20)
            makeDifficultyFilter(difficultyLabel: "Easy", difficultyColor: .green,
                                 isChecked: $presenter.showEasyTrails)
            makeDifficultyFilter(difficultyLabel: "Moderate", difficultyColor: .orange,
                                 isChecked: $presenter.showModerateTrails)
            makeDifficultyFilter(difficultyLabel: "Difficult", difficultyColor: .red,
                                 isChecked: $presenter.showDifficultTrails)
        }
    }
    
    private var priceRange: some View {
        VStack(alignment: .leading) {
            FilterViewUtility.makeFilterSectionTitle("Price Range")
                .padding(.vertical, 20)
            Text("$\(sliderLowerValue) - $\(sliderUpperValue)")
            CustomSliderView(slider: slider)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
        }.frame(maxWidth: .infinity)
    }
    
    var body: some View {
        FilterViewUtility.makeFilterSheet {
            VStack(alignment: .leading) {
                difficultyFilters
                Divider()
                    .padding(.vertical, 10)
                priceRange
            }.padding(.horizontal, 50)
        }
    }
}

struct TrailListingFilter_Previews: PreviewProvider {
    static var previews: some View {
        TrailListingFilter(presenter: TrailListingPresenter())
    }
}
