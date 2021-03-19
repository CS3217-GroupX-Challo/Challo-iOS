//
//  GuideProfileDetailsView.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideProfileDetailsView: View {
    var rating: Double
    var name: String
    var date: String
    var languages: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.largeTitle)
                .bold()
            StarRatingsView(rating: rating)
                .padding(5)
            Text("Active since \(date)")
                .font(.caption2)
                .italic()
                .padding(5)
            Text("Speaks")
                .font(.caption2)
                .italic()
                .padding(5)
        }
    }
}
