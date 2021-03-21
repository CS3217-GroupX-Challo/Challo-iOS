//
//  UnwrapView.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct UnwrapView<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
