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
        UnwrapView(presenter.currentTrail) { trail in
            GeometryReader { geometry in
                VStack {
                    Image.guidesBackground
                        .resizable()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height / 4,
                               alignment: .center)
                    TrailProfileDetails(trail: trail)
                        .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
