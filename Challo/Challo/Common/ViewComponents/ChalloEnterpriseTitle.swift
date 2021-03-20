//
//  ChalloEnterpriseTitle.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//
import SwiftUI

struct ChalloEnterpriseTitle: View {
    var body: some View {
        VStack(spacing: 0) {
            ChalloTitle()
            Text("Enterprise")
                .foregroundColor(.themeForeground)
                .font(.subheadline)
                .offset(y: -30)
        }
    }
}

struct ChalloEnterpriseTitle_Previews: PreviewProvider {
    static var previews: some View {
        ChalloEnterpriseTitle()
    }
}
