//
//  ItineraryEditorBar.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import SwiftUI

struct ItineraryEditorBar: View {
    var presenter: MapItineraryPresenter
    var paddingTop: CGFloat
    
    var isMarkerSelected: Bool {
        presenter.isMarkerSelected
    }
    
    var isRouteSelected: Bool {
        presenter.isRouteSelected
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
                                    imageName: "mappin")
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
                                    imageName: "airplane.circle.fill")
            }
            Spacer()
            Button(action: ({
                // TODO add save status
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 10,
                                    paddingLeading: 0,
                                    title: "Save",
                                    imageName: "arrow.up.doc.on.clipboard")
            }
        }
        .background(Color.gray)
    }
}
