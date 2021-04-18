//
//  TrailListingFilter.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct TrailListingFilter: View {
    @EnvironmentObject var presenter: TrailListingPresenter
    
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
    
    var body: some View {
        FilterViewUtility.makeFilterSheet {
            VStack(alignment: .leading) {
                difficultyFilters
                Divider()
                    .padding(.vertical, 10)
                PriceFilterView<TrailListingPresenter>(presenter: presenter)
            }.padding(.horizontal, 50)
        }
    }
}
