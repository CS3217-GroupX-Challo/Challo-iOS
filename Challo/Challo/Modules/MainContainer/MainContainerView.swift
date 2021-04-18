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
            tabs.accentColor(.themeTertiary)
        }.accentColor(.themeTertiary)
    }

    #if GUIDE
    var tabs: some View {
        TabView(selection: $presenter.tabSelection) {
            presenter.getProfilePage()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile").bold()
                }
                .tag(0)

            presenter.getChatPage()
                .tabItem {
                    Image(systemName: "envelope")
                    Text("Inbox").bold()
                }
                .tag(1)
        }
    }
    #elseif TOURIST
    var tabs: some View {
        TabView(selection: $presenter.tabSelection) {
            presenter.getGuidePage()
                .tabItem {
                    Image(systemName: "figure.wave.circle.fill")
                    Text("Guides").bold()
                }
                .tag(0)

            presenter.getHomestayPage()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Homestay").bold()
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
        }
    }
    #endif
}
