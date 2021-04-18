//
//  ChatDialogView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatDialogView: View {
    @EnvironmentObject var presenter: ChatPresenter

    let dialogId: String
    let chateeName: String
    let lastMessageDate: Date?
    let lastMessageText: String
    let unreadMessagesCount: UInt
    let chateeProfileImg: String?
    
    let profileImgDiameter: CGFloat = 90
    
    var lastMessageDateString: String {
        guard let lastMessageDate = lastMessageDate else {
            return ""
        }
        return presenter.formatDialogDatetime(lastMessageDate)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            ImageLoader(profileImg: chateeProfileImg,
                        width: profileImgDiameter,
                        height: profileImgDiameter,
                        defaultImage: "avatar-image")
                .scaledToFill()
                .frame(width: profileImgDiameter, height: profileImgDiameter, alignment: .center)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(chateeName).bold()
                    .font(.title3)
                    .padding(.bottom, 10)
                Text(lastMessageText)
                    .lineLimit(2)
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                Spacer()
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(lastMessageDateString)
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                if unreadMessagesCount != 0 {
                    Spacer()
                    Text(unreadMessagesCount.description)
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color.themeTertiary)
                                .frame(width: 25, height: 25)
                        )
                        .clipped()
                }
            }
        }.padding(.bottom, 30)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
    }
}
