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
            if presenter.isLoadingDialogs {
                Loading(isAnimating: .constant(true), style: .large)
            } else if presenter.isChatAvailable {
                ChatDialogListingView()
                    .padding(.top, 30)
            } else {
                VStack(spacing: 30) {
                    Image(systemName: "multiply.square")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(minWidth: 75, maxWidth: 75)
                    Text("An unexpected error occured while bringing up your chats :(")
                        .font(.system(size: 22))
                }
            }
        }.frame(width: geometry.size.width, height: geometry.size.height)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Inbox", headerContent: nil) { geometry in
            makeBody(geometry)
        }
    }
}
