//
//  Header.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct Header: View {

    var title: String
    var subtitle: String
    var image: Image

    var body: some View {
        ZStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.themePrimary)
                    .font(.largeTitle)
                    .bold()
                Text(subtitle)
                    .foregroundColor(.themeBackground)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .leading)
        .padding()
        .background(image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .layoutPriority(-1))
        .clipped()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Username",
               subtitle: "Ready to begin...",
               image: Image.mountainBackground)
            .previewLayout(.fixed(width: 500, height: 200))
    }
}
