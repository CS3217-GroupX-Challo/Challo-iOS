//
//  SettingsPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

struct SettingsPage: View {

    @EnvironmentObject var presenter: SettingsPresenter
    
    var body: some View {
        VStack {
            List(presenter.settingOptionViews, id: \.id) { settingOptionView in
                settingOptionView
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text("Settings"),
                            displayMode: .inline)
    }
}
