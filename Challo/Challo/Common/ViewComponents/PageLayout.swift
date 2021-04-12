//
//  PageLayout.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct PageLayout<ChildContent: View>: View {
    
    var titleLabel: String?
    var headerContent: AnyView?
    let makeChildContent: (_: GeometryProxy) -> ChildContent

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                        .brightness(-0.05)
                    VStack {
                        if let titleLabel = titleLabel {
                            HStack {
                                PageTitle(titleLabel: titleLabel, leading: geometry.size.width / 8)
                                Spacer()
                            }
                        }                        
                        headerContent
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height / (headerContent == nil ? 8 : 7))
                .clipped()
                GeometryReader { innerGeometry in
                    makeChildContent(innerGeometry)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
