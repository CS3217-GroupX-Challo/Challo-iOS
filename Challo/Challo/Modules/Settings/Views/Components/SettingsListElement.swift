//
//  SettingsListElementView.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

struct SettingsListElement<Content: View>: ContainerView {
    var content: () -> Content
    
    var body: some View {
        content()
    }
}
