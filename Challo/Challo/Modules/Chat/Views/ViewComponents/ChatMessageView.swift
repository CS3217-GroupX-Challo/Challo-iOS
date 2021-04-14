//
//  ChatMessageView.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

struct ChatMessageView: View, Hashable {
    let message: String
    let isSentByCurrentUser: Bool
    let isSuccessfullySent: Bool
    var shouldDisplayProfileImg: Bool = false
    let avatarWidth: CGFloat = 20
    let chateeName: String
    let profileImg: String?
    
    var backgroundColor: Color {
        isSentByCurrentUser ? Color.blue : Color(.systemGray6)
    }
    
    var nameColor: Color {
        isSentByCurrentUser ? Color(.systemGray4) : Color(.systemGray)
    }
    
    var messageColor: Color {
        isSentByCurrentUser ? .white : .black
    }
    
    var profileImage: some View {
        ImageLoader(profileImg: profileImg, width: avatarWidth, height: avatarWidth, defaultImage: "avatar-image")
            .frame(width: avatarWidth, height: avatarWidth)
            .clipShape(Circle())
    }
    
    @ViewBuilder
    func makeMessageSideView(_ isSentByCurrentUser: Bool) -> some View {
        if isSentByCurrentUser {
            Spacer()
        } else if shouldDisplayProfileImg {
            profileImage
        } else {
            Spacer().frame(maxWidth: avatarWidth)
        }
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            makeMessageSideView(isSentByCurrentUser)
            ChatBubble(direction: isSentByCurrentUser ? .right : .left) {
                VStack(alignment: isSentByCurrentUser ? .trailing : .leading, spacing: 2) {
                    Text(isSentByCurrentUser ? "You" : chateeName)
                        .bold()
                        .foregroundColor(nameColor)
                        .font(.system(size: 14))
                    Text(message)
                        .foregroundColor(messageColor)
                }.padding(20)
                .background(backgroundColor)
                .shadow(radius: 5)
            }
            makeMessageSideView(!isSentByCurrentUser)
        }
    }
}
