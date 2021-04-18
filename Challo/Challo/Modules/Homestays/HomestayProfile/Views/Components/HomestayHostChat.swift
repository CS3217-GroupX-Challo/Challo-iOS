//
//  HomestayHostChat.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayHostChat: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter
        
    var host: Host? {
        presenter.currentEntity?.host
    }
    
    let profileImgDiameter: CGFloat = 100
    
    var isSendDisabled: Bool {
        presenter.chatMessageText.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Chat with \(host?.name ?? "Host")")
                    .font(.headline)
                Spacer()
                ImageLoader(profileImg: host?.profileImg, width: profileImgDiameter, height: profileImgDiameter,
                            defaultImage: "avatar-image")
                    .frame(width: profileImgDiameter, height: profileImgDiameter)
                    .clipShape(Circle())
            }.padding(.horizontal, 30)
            Divider().padding(.vertical, 30)
            VStack {
                TextEditor(text: $presenter.chatMessageText)
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(.systemGray3), lineWidth: 2)
                    )
                Button(action: {
                    presenter.isChatSheetOpen = false
                    presenter.onTapSendMessage()
                }) {
                    Text("Send Message").bold()
                        .padding()
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSendDisabled ? Color.gray :Color.themeTertiary)
                )
                .padding(.top, 30)
                .disabled(isSendDisabled)
            }
        }.padding(.vertical, 50)
        .padding(.horizontal, 50)
    }
}
