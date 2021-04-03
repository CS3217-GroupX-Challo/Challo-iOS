//
//  ChatErrorView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatErrorView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "multiply.square")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(minWidth: 75, maxWidth: 75)
            Text("An unexpected error occured while bringing up your chats :(")
                .font(.system(size: 22))
        }
    }
}
