//
//  SettingsLogOutButton.swift
//  Challo
//
//  Created by Shao Yi on 21/3/21.
//

import SwiftUI

struct SettingsLogOutButton: View {
    let loginPage: AnyView
    let presenter: SettingsPresenter!
    
    var body: some View {
        NavigationLink(destination: loginPage) {
            HStack(alignment: .center) {
                Text("Log out").foregroundColor(Color.blue)
                Spacer()
                Image(systemName: "arrow.down.left.circle.fill")
            }
        }.simultaneousGesture(TapGesture().onEnded {
            presenter.onTapLogOut()
        })
    }
}
