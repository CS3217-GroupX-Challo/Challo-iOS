//
//  PageLayout.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct PageLayout<ChildContent: View>: View {
    
    let titleLabel: String
    let headerContent: AnyView? = nil
    let makeChildContent: () -> ChildContent
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                    VStack {
                        HStack {
                            PageTitle(titleLabel: titleLabel, leading: geometry.size.width / 8)
                            Spacer()
                        }
                        headerContent
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height / 5,
                       alignment: .center)
                makeChildContent()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
