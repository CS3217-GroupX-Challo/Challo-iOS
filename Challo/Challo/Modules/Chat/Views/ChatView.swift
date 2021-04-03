//
//  ChatView.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var presenter: ChatPresenter
    
    var body: some View {
        PageLayout(titleLabel: "Inbox", headerContent: nil) { geometry in
            VStack(alignment: .leading) {
                if presenter.isLoadingDialogs {
                    Loading(isAnimating: .constant(true), style: .large)
                } else {
                    ChatDialogListingView()
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
            .padding(.top, 30)
        }
    }
}
