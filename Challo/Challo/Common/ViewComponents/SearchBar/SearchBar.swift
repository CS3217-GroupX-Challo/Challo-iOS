//
//  SearchBar.swift
//  Challo
//
//  Created by Shao Yi on 11/4/21.
//

import SwiftUI

struct SearchBar<Presenter: SearchBarPresenter>: View {
    @EnvironmentObject var presenter: Presenter
    @State private var isEditing = false
    
    var placeholder: String = "Search..."
 
    var body: some View {
        HStack {
            TextField(placeholder, text: $presenter.searchBarText)
                .padding(7)
                .padding(.horizontal, 25)
                .border(Color(.systemGray6))
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 6)
                )
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(Font.headline.weight(.semibold))
                            .foregroundColor(.themeTertiary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                presenter.searchBarText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.themeTertiary)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    presenter.searchBarText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar<ChatPresenter>().environmentObject(ChatPresenter())
    }
}
