//
//  PageLayout.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct PageLayout<ChildContent: View>: View {
    
    var titleLabel: String?
    var background: Image = .guidesBackground
    var headerContent: AnyView?
    let makeChildContent: (_: GeometryProxy) -> ChildContent

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    background
                        .resizable()
                        .scaledToFill()
                        .brightness(-0.05)
                    VStack {
                        if let titleLabel = titleLabel {
                            HStack {
                                PageTitle(titleLabel: titleLabel)
                                    .padding(.leading, geometry.size.width / 8)
                                Spacer()
                            }
                        }
                        headerContent
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height / (headerContent == nil ? 6.5 : 5.5))
                .clipped()
                GeometryReader { innerGeometry in
                    makeChildContent(innerGeometry)
                }.padding(.top, 30)
                .padding(.horizontal, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
