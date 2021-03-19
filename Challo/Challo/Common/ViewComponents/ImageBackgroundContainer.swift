//
//  Background.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//

import SwiftUI

struct ImageBackgroundContainer<Content: View>: ContainerView {
    var content: () -> Content

    var body: some View {
        ZStack {
            content()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .background(Image.mountainBackground
                     .resizable()
                     .aspectRatio(contentMode: .fill))
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        ImageBackgroundContainer {
            Text("Hello!")
        }
    }
}
