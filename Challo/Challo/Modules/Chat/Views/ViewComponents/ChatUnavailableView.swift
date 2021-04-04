//
//  ChatUnavailableView.swift
//  Challo
//
//  Created by Shao Yi on 3/4/21.
//

import SwiftUI

struct ChatUnavailableView: View {
    let imageSystemName: String
    let label: String
    var imageColor: Color?
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: imageSystemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(imageColor ?? Color.themeTertiary)
                .frame(minWidth: 75, maxWidth: 75)
            Text(label)
                .font(.system(size: 22))
        }
    }
}
