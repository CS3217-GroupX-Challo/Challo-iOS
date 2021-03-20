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
            TabView {
                Text("Home Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home").bold()
                    }
             
                Text("Explore Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "car.fill")
                        Text("Explore").bold()
                    }
             
                presenter.getGuidePage()
                    .tabItem {
                        Image(systemName: "figure.wave.circle.fill")
                        Text("Guides").bold()
                    }
                
                presenter.getTrailPage()
                    .tabItem {
                        Image(systemName: "leaf.fill")
                        Text("Trails").bold()
                    }
             
                presenter.getMapsPage()
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Map").bold()
                    }
                
                presenter.getProfilePage()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile").bold()
                    }
    
            }.accentColor(.themeTertiary)
        }.accentColor(.themeTertiary)
    }
}
