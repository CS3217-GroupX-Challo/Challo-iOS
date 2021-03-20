//
//  InteractiveMapPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import GoogleMaps

struct InteractiveMapPage: View {
    var body: some View {
        GoogleMapsView()
            .edgesIgnoringSafeArea(.all)
    }
}
