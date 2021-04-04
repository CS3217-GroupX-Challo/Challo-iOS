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
        if presenter.dialogs.isEmpty {
            ChatUnavailableView(imageSystemName: "tray",
                                label: "You have no open conversations")
        } else {
            VStack {
                ChatDialogSearchBar()
                ScrollView {
                    ForEach(presenter.filteredDialogs, id: \.chateeId) { dialog in
                        NavigationLink(destination: ChatMessageList(chateeName: dialog.chateeName ?? "")
                                        .environmentObject(presenter)) {
                            VStack {
                                ChatDialogView(dialogId: dialog.dialogId,
                                               chateeName: dialog.chateeName ?? "",
                                               lastMessageDate: dialog.lastMessageDate,
                                               lastMessageText: dialog.lastMessageText,
                                               unreadMessagesCount: dialog.unreadMessagesCount)
                                    .accentColor(.black)
                                Divider()
                            }
                        }.simultaneousGesture(TapGesture().onEnded {
                            presenter.onTapDialog(dialogId: dialog.dialogId)
                        })
                    }
                }
            }.padding(.horizontal, 15)
        }
    }
}
