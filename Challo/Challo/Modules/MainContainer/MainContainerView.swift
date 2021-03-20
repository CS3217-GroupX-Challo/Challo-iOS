//
//  MainContainerView.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

struct MainContainerView: View {
    
    @EnvironmentObject var presenter: MainContainerPresenter
    @State private var selection = 0
    
    init() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = .black
        tabBarAppearance.unselectedItemTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Text("Home Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home").bold()
                    }
                    .tag(0)
             
                Text("Explore Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "car.fill")
                        Text("Explore").bold()
                    }
                    .tag(1)
             
                presenter.getGuidePage()
                    .tabItem {
                        Image(systemName: "figure.wave.circle.fill")
                        Text("Guides").bold()
                    }
                    .tag(2)
                
                presenter.getTrailPage()
                    .tabItem {
                        Image(systemName: "leaf.fill")
                        Text("Trails").bold()
                    }
                    .tag(3)
             
                presenter.getProfilePage()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile").bold()
                    }
                    .tag(4)
            }.accentColor(.themeTertiary)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
