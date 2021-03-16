//
//  DropDownMenu.swift
//  Challo
//
//  Created by Kester Ng on 16/3/21.
//

import SwiftUI

struct DropDownMenu: View {
    @State var isExpanded: Bool = false
    
    // menu related properties
    @Binding var selectedOption: String
    var menuItems: [String]
    var menuTitle: String
    
    // UI related properties
    var width: CGFloat
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(menuTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13,
                               height: 6,
                               alignment: .center)
                        .foregroundColor(.black)
                }
                .onTapGesture {
                    self.isExpanded.toggle()
                }
            }
            if isExpanded {
                ForEach(menuItems, id: \.self) { menuItem in
                    Button(action: {
                        self.selectedOption = menuItem
                        self.isExpanded.toggle()
                    }) {
                        Text(menuItem)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 13)
                                        .stroke(Color.themeTertiary, lineWidth: 2))
                    }
                }
            }
        }
        .frame(width: width)
    }
}
