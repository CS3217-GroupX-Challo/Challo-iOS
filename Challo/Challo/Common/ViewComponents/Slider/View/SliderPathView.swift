//
//  SliderPathView.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct SliderPathView: View {
    @ObservedObject var slider: CustomSlider
        
    var body: some View {
        Path { path in
            path.move(to: slider.lowHandle.currentLocation)
            path.addLine(to: slider.highHandle.currentLocation)
        }
        .stroke(Color.green, lineWidth: slider.lineWidth)
    }
}
