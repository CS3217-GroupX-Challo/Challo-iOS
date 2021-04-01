//
//  InteractiveMapPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import GoogleMaps

struct InteractiveMapPage: View {
    @ObservedObject var presenter: MapPresenter
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TextField("Search...",
                          text: $presenter.searchQuery,
                          onCommit: {
                            presenter.findPlaces()
                          })
                    .textFieldStyle(RoundedTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .frame(width: geometry.size.width * 1 / 2,
                           height: geometry.size.height / 20,
                           alignment: .center)
                    .offset(x: 0, y: -1 * geometry.size.height * 7 / 16)
                    .zIndex(1)
                presenter.googleMapsView
                    .zIndex(0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}
