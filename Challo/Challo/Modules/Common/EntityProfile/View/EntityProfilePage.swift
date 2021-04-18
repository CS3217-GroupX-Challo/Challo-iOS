//
//  EntityProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct EntityProfilePage<Presenter: EntityProfilePresenter>: View {
    @EnvironmentObject var presenter: Presenter
    
    let defaultImage: String
    let detailsContent: () -> AnyView
    let stickyBarContent: () -> AnyView
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        ImageLoader(profileImg: presenter.currentEntityImage,
                                    width: geometry.size.width,
                                    height: geometry.size.height / 3.0,
                                    defaultImage: defaultImage)
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height / 3.0,
                                   alignment: .center)
                        detailsContent()
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                    }
                    Spacer().frame(height: 100)
                }
            }
            EntityProfileStickyBar {
                stickyBarContent()
            }.frame(maxHeight: 100)
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $presenter.isShowingNotLoggedInAlert) {
            Alert(title: Text("You are not currently logged in"),
                  message: Text("Please log in to continue"),
                  dismissButton: .default(Text("Close")))
        }
    }
}
