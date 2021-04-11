//
//  ReviewPage.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct ReviewPage: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Header(title: "Leave a Review",
                           subtitle: "",
                           image: Image.mountainBackground)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.15,
                               alignment: .center)
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ReviewPage_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPage()
    }
}
