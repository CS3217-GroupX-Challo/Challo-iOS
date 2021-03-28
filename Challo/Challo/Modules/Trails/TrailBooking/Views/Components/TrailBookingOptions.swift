//
//  TrailBookingOptions.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingOptions: View {

    @State private var selectedPax = 0
    @State private var paxRange = [1, 2, 3, 4, 5]

    var body: some View {
        Form {
            TrailPaxSelection(selectedPax: $selectedPax,
                              paxRange: $paxRange)
            Text("Total cost: ")
        }
        .padding()
    }
}

struct TrailBookingOptions_Previews: PreviewProvider {
    static var previews: some View {
        TrailBookingOptions()
    }
}
