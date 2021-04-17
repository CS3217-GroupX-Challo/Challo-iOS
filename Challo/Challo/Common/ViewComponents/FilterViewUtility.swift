//
//  FilterViewUtility.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct FilterViewUtility {
    static func makeFilterTitle() -> some View {
        VStack {
            Text("Filters")
                .font(.headline)
                .padding(.vertical, 20)
            Divider()
        }
    }
    
    static func makeFilterSheet<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack {
            makeFilterTitle()
            content()
            Spacer()
        }
    }
    
    static func makeCheckBoxFilter<Content: View>(isChecked: Binding<Bool>,
                                                  @ViewBuilder textLabel: () -> Content) -> some View {
        HStack {
            textLabel()
            Spacer()
            RectangleCheckBox(length: 40, isChecked: isChecked)
        }
    }
    
    static func makeFilterSectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline).bold()
    }
}
