//
//  ItineraryEditorBar.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import SwiftUI

struct ItineraryEditorBar: View {
    @ObservedObject var presenter: MapItineraryPresenter
    var paddingTop: CGFloat
        
    var isMarkerSelected: Bool {
        presenter.isMarkerSelected
    }
    
    var isRouteSelected: Bool {
        presenter.isRouteSelected
    }
    
    var isDeletedSelected: Bool {
        presenter.isDeleteSelected
    }
    
    var isSaveSelected: Bool {
        presenter.isSaveSelected
    }
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: ({
                presenter.resetButtonSelection(selectionStatus: isMarkerSelected)
                presenter.isMarkerSelected.toggle()
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 0,
                                    paddingLeading: 10,
                                    title: "Marker",
                                    imageName: "mappin",
                                    isSelected: $presenter.isMarkerSelected)
            }
            Button(action: ({
                presenter.resetButtonSelection(selectionStatus: isRouteSelected)
                presenter.isRouteSelected.toggle()
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 0,
                                    paddingLeading: 0,
                                    title: "Route",
                                    imageName: "airplane.circle.fill",
                                    isSelected: $presenter.isRouteSelected)
            }
            Button(action: ({
                presenter.resetButtonSelection(selectionStatus: isDeletedSelected)
                presenter.isDeleteSelected.toggle()
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 0,
                                    paddingLeading: 0,
                                    title: "Delete",
                                    imageName: "trash.fill",
                                    isSelected: $presenter.isDeleteSelected)
            }
            Spacer()
            Button(action: ({
                // TODO add save status
                presenter.isSaveSelected.toggle()
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 10,
                                    paddingLeading: 0,
                                    title: "Save",
                                    imageName: "arrow.up.doc.on.clipboard",
                                    isSelected: $presenter.isSaveSelected)
            }
        }
        .background(Color.gray)
    }
}
