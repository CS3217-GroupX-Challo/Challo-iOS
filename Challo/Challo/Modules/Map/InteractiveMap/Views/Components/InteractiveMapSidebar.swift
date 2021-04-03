//
//  InteractiveMapSidebar.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct InteractiveMapSidebar: View {
    
    @EnvironmentObject var presenter: MapPresenter

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Itineraries"), displayMode: .inline)
    }
}

struct InteractiveMapSidebar_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveMapSidebar()
    }
}
