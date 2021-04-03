//
//  ChatDialogView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatDialogView: View {
    let dialogId: String
    let chateeName: String
    let lastMessageDay: String
    let unreadMessagesCount: UInt
    
    var body: some View {
        HStack(spacing: 20) {
            Image("avatar-image")
                .resizable()
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(chateeName).bold()
                    .font(.system(size: 24))
                Spacer()
                Text("recentrecentrecentrecentrecentrecentrecentrecentrecentrecent" +
                        "recentrecentrecentrecentrecentrecentrecentrecentrecentrecentrecent message")
                    .lineLimit(2)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 18))
            }
            Spacer()
            VStack {
                Text(lastMessageDay)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 18))
                Spacer()
                Text(unreadMessagesCount.description)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color.themeTertiary)
                            .frame(width: 25, height: 25)
                    )
                    .clipped()
            }
        }.padding(.vertical, 30)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
    }
}
