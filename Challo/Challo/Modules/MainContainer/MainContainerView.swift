//
//  MainContainerView.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

struct MainContainerView: View {
    
    @EnvironmentObject var presenter: MainContainerPresenter
    
    init() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = .black
        tabBarAppearance.unselectedItemTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            presenter.getSettingsPage()
            TabView(selection: $presenter.tabSelection) {
                presenter.getHomePage()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home").bold()
                    }
                    .tag(0)

                presenter.getGuidePage()
                    .tabItem {
                        Image(systemName: "figure.wave.circle.fill")
                        Text("Guides").bold()
                    }
                    .tag(1)

                presenter.getTrailPage()
                    .tabItem {
                        Image(systemName: "leaf.fill")
                        Text("Trails").bold()
                    }
                    .tag(2)

                presenter.getMapsPage()
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Map").bold()
                    }
                    .tag(3)

                presenter.getChatPage()
                    .tabItem {
                        Image(systemName: "envelope")
                        Text("Inbox").bold()
                    }
                    .tag(4)
                
                presenter.getProfilePage()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile").bold()
                    }
                    .tag(5)

            }.accentColor(.themeTertiary)
        }.accentColor(.themeTertiary)
    }
}
