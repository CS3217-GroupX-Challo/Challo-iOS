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
    let profileImg: String?
    
    var backgroundColor: Color {
        isSentByCurrentUser ? Color.themeTertiary : Color(.systemGray2)
    }
    
    var strokeColor: Color {
        isSuccessfullySent ? backgroundColor : Color.red
    }
    
    var profileImage: some View {
        ImageLoader(profileImg: profileImg, width: avatarWidth, height: avatarWidth, defaultImage: "avatar-image")
            .frame(width: avatarWidth, height: avatarWidth)
            .clipShape(Circle())
    }
    
    @ViewBuilder
    func makeMessageSideView(_ condition: Bool) -> some View {
        if condition {
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
            Text(message)
                .padding(15 )
                .foregroundColor(.white)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(strokeColor, lineWidth: 1))
                .font(Font.system(size: 20, weight: .regular))
            makeMessageSideView(!isSentByCurrentUser)
        }
    }
}
