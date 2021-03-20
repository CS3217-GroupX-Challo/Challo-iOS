//
//  SettingsRouter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

class SettingsRouter: RouterProtocol {
    weak var presenter: SettingsPresenter!
    
    func makeLogOutButton() -> SettingsListElement<AnyView> {
        let (loginPage, _) = TouristLoginModule.assemble()
        return SettingsListElement {
            AnyView(
                NavigationLink(destination: loginPage.navigationBarHidden(true)) {
                    HStack(alignment: .center) {
                        Button(action: {
                            print("Pressed logged out!")
                        }, label: {
                           Text("Log out")
                            .foregroundColor(Color.blue)
                        })
                        Spacer()
                        Image(systemName: "arrow.down.left.circle.fill")
                    }
                }
            )
        }
    }
}
