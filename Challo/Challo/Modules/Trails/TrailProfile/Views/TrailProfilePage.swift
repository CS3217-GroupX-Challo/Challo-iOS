//
//  TrailProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfilePage: View {
    @EnvironmentObject var presenter: TrailProfilePresenter
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Image.guidesBackground
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height / 3.0,
                                   alignment: .center)
                        TrailProfileDetails()
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                    }
                    Spacer().frame(height: 100)
                }
            }
            TrailProfileStickyBar()
                .innerShadow(color: .gray, radius: 0.03, exclude: [.bottom, .leading, .trailing])
                .frame(maxHeight: 100)
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $presenter.isShowingNotLoggedInAlert) {
            Alert(title: Text("You are not currently logged in"),
                  message: Text("Please log in to continue"),
                  dismissButton: .default(Text("Close")))
        }
    }
}
