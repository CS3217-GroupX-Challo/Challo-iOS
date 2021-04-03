//
//  ChatView.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var presenter: ChatPresenter
    
    @ViewBuilder
    func makeBody(_ geometry: GeometryProxy) -> some View {
        ZStack(alignment: .center) {
            if !presenter.canDisplayChat {
                ChatUnavailableView()
            } else if presenter.isLoadingDialogs {
                Loading(isAnimating: .constant(true), style: .large)
            } else if presenter.isChatAvailable {
                ChatDialogListingView().padding(.top, 30)
            } else {
                ChatErrorView()
            }
        }.frame(width: geometry.size.width, height: geometry.size.height)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Inbox", headerContent: nil) { geometry in
            makeBody(geometry)
        }.onAppear(perform: presenter.onChatAppear)
    }
}
