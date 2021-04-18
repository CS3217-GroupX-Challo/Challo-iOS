//
//  ChatMessageList.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

struct ChatMessageList: View {
    @EnvironmentObject var presenter: ChatPresenter
    
    let chateeName: String
    
    let chateeProfilePicDiameter: CGFloat = 35
    
    var topBar: some View {
        HStack {
            Text(chateeName)
            ImageLoader(profileImg: presenter.currentOpenChateeProfileImg,
                        width: chateeProfilePicDiameter,
                        height: chateeProfilePicDiameter,
                        defaultImage: "avatar-image")
                .scaledToFit()
                .clipShape(Circle())
                .frame(maxWidth: chateeProfilePicDiameter)
        }.padding(.leading, 30)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Spacer()
                Divider().background(Color.gray)
                    .shadow(color: .gray, radius: 1, y: 1)
                    .shadow(color: .gray, radius: 3, y: 2)
            }.frame(minHeight: 80, maxHeight: 80)
            VStack {
                if presenter.isLoadingMessages {
                    Loading(isAnimating: .constant(true), style: .large)
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            presenter.makeMessagesView()
                        }
                    }
                }
                ChatMessageTextBar()
            }.padding(.horizontal, 40)
            .padding(.top, 30)
        }.edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(leading: topBar)
    }
}
