//
//  ContactTouristPage.swift
//  Challo
//
//  Created by Ying Gao on 17/4/21.
//

import SwiftUI

struct ContactTouristPage: View {

    @EnvironmentObject var presenter: GuideUpcomingBookingsPresenter
    @Environment(\.presentationMode) var presentationMode

    var tourist: Tourist

    var body: some View {
        VStack(alignment: .leading) {
            touristCard
            Divider().padding(.vertical)
            Text("Most customers would like to know about:")
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
                presenter.sendMessageOnTap(recipient: tourist)
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

    private var touristCard: some View {
        HStack {
            Text("Contact \(tourist.name ?? "")")
                .font(.title2)
            Spacer()
            Image("avatar-image")
                .resizable()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
        }
    }
}
