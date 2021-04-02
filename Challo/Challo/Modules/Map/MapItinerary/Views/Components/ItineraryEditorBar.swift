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
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: ({
                print("Add marker button pressed")
            }
            )) {
                ItineraryButtonView(paddingTop: paddingTop,
                                    paddingTrailing: 0,
                                    paddingLeading: 10,
                                    title: "Marker",
                                    imageName: "mappin")
            }
            Button(action: ({
                print("Add route button pressed")
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
                print("Save button pressed")
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
