//
//  ItineraryButtonView.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import SwiftUI

struct ItineraryButtonView: View {
    let paddingTop: CGFloat
    let paddingTrailing: CGFloat
    let paddingLeading: CGFloat
    let title: String
    let imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .padding(EdgeInsets(top: paddingTop,
                                    leading: paddingLeading,
                                    bottom: 0,
                                    trailing: paddingTrailing))
            Text(title)
                .padding(EdgeInsets(top: 0,
                                    leading: paddingLeading,
                                    bottom: 0,
                                    trailing: paddingTrailing))
        }
    }
}
