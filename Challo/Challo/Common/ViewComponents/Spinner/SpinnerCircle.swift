//
//  SpinnerCircle.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}
