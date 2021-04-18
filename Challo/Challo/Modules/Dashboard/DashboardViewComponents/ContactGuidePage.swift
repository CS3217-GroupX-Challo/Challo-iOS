//
//  ContactGuidePage.swift
//  Challo
//
//  Created by Shao Yi on 4/4/21.
//

import SwiftUI

struct ContactGuidePage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter
    @Environment(\.presentationMode) var presentationMode
    
    let guide: Guide
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Contact \(guide.name ?? "")")
                    .font(.title2)
                Spacer()
                Image("avatar-image")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
            }
            Divider().padding(.vertical)
            Text("Most travellers ask about")
                .font(.headline)
                .padding(.vertical, 30)
            Text("- Getting there")
                .font(.subheadline)
                .bold()
            Text("- House details and rules")
                .font(.subheadline)
                .bold()
            Divider().padding(.vertical)
            Text("Message your guide")
                .font(.headline)
                .padding(.vertical, 30)
            TextEditor(text: $presenter.messageText)
                .padding()
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray3), lineWidth: 2)
                )
            Divider().padding(.vertical)
            Button(action: {
                presenter.onTapSendMessage(guide: guide)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Send Message").bold()
                    .padding()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.themeTertiary)
            )
            .padding(.bottom)
        }.padding(.horizontal, 50)
    }
}
