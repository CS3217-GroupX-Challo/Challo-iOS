//
//  TrailListingFilter.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct TrailListingFilter: View {
    
    @EnvironmentObject var presenter: TrailListingPresenter
    
    private func makeSectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline).bold()
    }
    
    private func makeFilter<Content: View>(isChecked: Binding<Bool>,
                                           @ViewBuilder textLabel: () -> Content) -> some View {
        HStack {
            textLabel()
            Spacer()
            RectangleCheckBox(length: 40, isChecked: isChecked)
        }
    }
    
    private func makeDifficultyFilter(difficultyLabel: String, difficultyColor: Color,
                                      isChecked: Binding<Bool>) -> some View {
        makeFilter(isChecked: isChecked) {
            HStack {
                Text(difficultyLabel)
                    .foregroundColor(difficultyColor)
                Text("Trails")
            }
        }
    }
    
    private var difficultyFilters: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading) {
                makeSectionTitle("Difficulty")
                Text("Trails are ranked a difficulty according to their terrain, distance & elevation.")
                    .foregroundColor(Color.gray)
            }.padding(.vertical, 10)
            makeDifficultyFilter(difficultyLabel: "Easy", difficultyColor: .green,
                                 isChecked: $presenter.showEasyTrails)
            makeDifficultyFilter(difficultyLabel: "Moderate", difficultyColor: .orange,
                                 isChecked: $presenter.showModerateTrails)
            makeDifficultyFilter(difficultyLabel: "Difficult", difficultyColor: .red,
                                 isChecked: $presenter.showDifficultTrails)
        }
    }
    
    private var divider: some View {
        Divider().padding(.vertical, 10)
    }
    
    var body: some View {
        VStack {
            Text("Filters")
                .font(.headline)
            divider
            VStack(alignment: .leading) {
                difficultyFilters
                divider
                makeSectionTitle("Price Range")
            }.padding(.horizontal, 50)
        }
    }
}

struct TrailListingFilter_Previews: PreviewProvider {
    static var previews: some View {
        TrailListingFilter().environmentObject(TrailListingPresenter())
    }
}
