//
//  View+InnerShadow.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

extension View {
    func innerShadow(color: Color, radius: CGFloat = 0.1, exclude: [Alignment] = []) -> some View {
        modifier(InnerShadow(color: color, radius: min(max(0, radius), 1), exclude: exclude))
    }
}

private struct InnerShadow: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1
    var exclude: [Alignment] = []

    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .if(!exclude.contains(.top)) {
                    $0.overlay(LinearGradient(gradient: Gradient(colors: self.colors),
                                              startPoint: .top, endPoint: .bottom)
                                .frame(height: self.radius * self.minSide(geo)), alignment: .top)
                }
                .if(!exclude.contains(.bottom)) {
                    $0.overlay(LinearGradient(gradient: Gradient(colors: self.colors),
                                              startPoint: .bottom, endPoint: .top)
                                .frame(height: self.radius * self.minSide(geo)), alignment: .bottom)
                }
                .if(!exclude.contains(.leading)) {
                    $0.overlay(LinearGradient(gradient: Gradient(colors: self.colors),
                                              startPoint: .leading, endPoint: .trailing)
                                .frame(width: self.radius * self.minSide(geo)), alignment: .leading)
                }
                .if(!exclude.contains(.trailing)) {
                    $0.overlay(LinearGradient(gradient: Gradient(colors: self.colors),
                                              startPoint: .trailing, endPoint: .leading)
                                .frame(width: self.radius * self.minSide(geo)), alignment: .trailing)
                }
        }
    }

    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}
