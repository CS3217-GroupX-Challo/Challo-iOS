//
//  BookingCardLayout.swift
//  Challo
//
//  Created by Ying Gao on 17/4/21.
//

import SwiftUI

struct BookingCardLayout<Content: View>: View {
    var width: CGFloat
    var content: () -> Content

    var body: some View {
        content()
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .background(Color.clear)
                    .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                    .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
            )
            .frame(width: width,
                   alignment: .center)
            .padding()
    }
}
