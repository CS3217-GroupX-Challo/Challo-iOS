//
//  PageLayout.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct PageLayout<ChildContent: View>: View {
    
    let titleLabel: String
    var headerContent: AnyView?
    let makeChildContent: (_: GeometryProxy) -> ChildContent
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                        .scaledToFill()
                    VStack {
                        HStack {
                            Spacer()
                            PageTitle(titleLabel: titleLabel)
                                .padding(.trailing, geometry.size.width / 12)
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
