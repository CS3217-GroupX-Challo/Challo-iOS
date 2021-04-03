//
//  ChatUnavailableView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatUnavailableView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "lock.rectangle.on.rectangle")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.themeTertiary)
                .frame(minWidth: 75, maxWidth: 75)
            Text("You have not logged in yet. Log in to chat with our guides!")
                .font(.system(size: 22))
        }
    }
}
