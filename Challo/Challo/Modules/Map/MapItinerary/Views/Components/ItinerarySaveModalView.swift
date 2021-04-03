//
//  ItinerarySaveModalView.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import SwiftUI

struct ItinerarySaveModalView: View {
    var title = "Save title"
    var presenter: MapItineraryPresenter
    var width: CGFloat
    
    @State var text: String = ""
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            RoundedTextField(placeholder: title,
                             text: $text,
                             isPasswordField: false)
                .frame(width: width)
            Button(action: ({
                isShowing.toggle()
            }), label: {
                Text("Save")
                    .padding(EdgeInsets(top: 10,
                                        leading: 10,
                                        bottom: 10,
                                        trailing: 10))
            })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.themeTertiary, lineWidth: 2)
            )
            .padding(.bottom)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.themeTertiary, lineWidth: 2)
        )
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}
