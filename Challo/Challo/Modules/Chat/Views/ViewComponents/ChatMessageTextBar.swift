//
//  ChatMessageTextBar.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatMessageTextBar: View {
    @EnvironmentObject var presenter: ChatPresenter
    
    var hasMessageText: Bool {
        !presenter.messageText.isEmpty
    }
 
    var body: some View {
        HStack {
            TextField("Message...", text: $presenter.messageText)
                .padding(.vertical, 7)
                .padding(.horizontal, 40)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                 
                        if hasMessageText {
                            Button(action: {
                                presenter.onTapMessageSend()
                            }) {
                                Text("Send")
                                    .foregroundColor(Color.themeTertiary)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
        }
    }
}
