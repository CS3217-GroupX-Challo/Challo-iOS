//
//  SettingsPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

struct SettingsPage: View {
    @State var settingOptionViews: [SettingsListElement<AnyView>]
    
    var body: some View {
        VStack {
            List(settingOptionViews, id: \.id) { settingOptionView in
                settingOptionView
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text("Settings"),
                            displayMode: .inline)
    }
}
