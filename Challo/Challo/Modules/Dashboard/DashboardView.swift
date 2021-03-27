//
//  DashboardView.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Header(title: "Challo Bernie",
                       subtitle: "Ready to begin your journey with us?",
                       image: Image.mountainBackground)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height * 0.15,
                           alignment: .center)
            }

            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
