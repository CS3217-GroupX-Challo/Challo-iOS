//
//  TrailProfileStickyBar.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileStickyBar: View {
    @EnvironmentObject var presenter: TrailProfilePresenter

    var body: some View {
        HStack {
            Spacer()
            Button(action: presenter.onTapBookTrailButton) {
                Text("Book This Trail")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.themeTertiary)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.themeTertiary, lineWidth: 1))
                    .padding([.top, .bottom], 10)
                    .font(Font.system(size: 15, weight: .semibold))
            }

        }.padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
    }
}
