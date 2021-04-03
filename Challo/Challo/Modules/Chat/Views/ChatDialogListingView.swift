//
//  ChatDialogListingView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatDialogListingView: View {
    @EnvironmentObject var presenter: ChatPresenter
        
    var body: some View {
        VStack {
            ChatDialogSearchBar()
            ScrollView {
                ForEach(presenter.filteredDialogs, id: \.chateeId) { dialog in
                    NavigationLink(destination: ChatMessageList(chateeName: dialog.chateeName)
                                    .environmentObject(presenter)) {
                        ChatDialogView(dialogId: dialog.dialogId,
                                       chateeName: dialog.chateeName,
                                       lastMessageDay: presenter.formatDialogDatetime(dialog.lastMessageDate),
                                       unreadMessagesCount: dialog.unreadMessagesCount)
                            .accentColor(.black)
                    }.simultaneousGesture(TapGesture().onEnded {
                        presenter.onTapDialog(dialogId: dialog.dialogId)
                    })
                }
            }
        }.padding(.horizontal, 15)
    }
}
