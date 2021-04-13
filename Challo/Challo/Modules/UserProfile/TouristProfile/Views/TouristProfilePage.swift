//
//  TouristProfilePage.swift
//  Challo
//
//  Created by Tan Le Yang on 10/4/21.
//

import SwiftUI

struct TouristProfilePage: View {

    var headingLabel: some View {
        Label {
            Text("Account Details")
                .foregroundColor(.themeForeground)
                .font(.largeTitle)
        } icon: {
            Image(systemName: "person.crop.circle.fill")
        }
    }

    var body: some View {
        VStack {
            headingLabel
            
        }
    }
}

struct TouristProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        TouristProfilePage()
    }
}
