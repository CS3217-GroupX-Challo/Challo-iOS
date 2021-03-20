//
//  LoginRegisterContainer.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

import SwiftUI

struct LoginRegisterContainer<Content: View>: ContainerView {
    var content: () -> Content

    var body: some View {
        LoginRegisterBackground {
            GeometryReader { geometry in
                VStack {
                    content()
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: .center)
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginRegisterContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterContainer {
            Text("Hello")
        }
    }
}
