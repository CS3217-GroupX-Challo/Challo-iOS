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
    
    var placeholder: String
    let searchBarSheet: AnyView?
    
    init(placeholder: String = "Search...", searchBarSheet: AnyView? = nil) {
        self.placeholder = placeholder
        self.searchBarSheet = searchBarSheet
    }
    
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
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        SearchBarRightButton<Presenter>(isEditing: $isEditing, isFilterable: searchBarSheet != nil)
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
 
            if isEditing {
                SearchBarCancelButton<Presenter>(isEditing: $isEditing)
            }
        }
        .sheet(isPresented: $presenter.isSearchBarSheetOpen) {
            searchBarSheet
        }
    }
}
