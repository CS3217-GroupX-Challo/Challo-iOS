//
//  Loading.swift
//  Challo
//
//  Created by Shao Yi on 21/3/21.
//

import SwiftUI

struct Loading: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<Loading>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loading>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
