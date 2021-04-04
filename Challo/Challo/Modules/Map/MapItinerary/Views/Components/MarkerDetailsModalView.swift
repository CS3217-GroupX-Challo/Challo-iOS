//
//  MarkerDetailsModalView.swift
//  Challo
//
//  Created by Kester Ng on 4/4/21.
//

import SwiftUI

struct MarkerDetailsModalView: View {
    @EnvironmentObject var presenter: MapItineraryPresenter
    let mapMarker: MapMarker
    
    var body: some View {
        VStack(alignment: .center) {
            DetailTitleView(title: "Date")
            DetailInformationTextView(information: "\(mapMarker.date?.destruct() ?? "No date given")")
            DetailTitleView(title: "Comments")
            DetailInformationTextView(information: mapMarker.comments ?? "No comments.")
            Button(action: ({
                presenter.isViewSelected.toggle()
            }), label: {
                Text("OK")
                    .padding(EdgeInsets(top: 10,
                                        leading: 10,
                                        bottom: 10,
                                        trailing: 10))
            })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.themeTertiary, lineWidth: 2)
            )
            .padding(.bottom)
        }
        .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.themeTertiary, lineWidth: 2)
        )
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}
