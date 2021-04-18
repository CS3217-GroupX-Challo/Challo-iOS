//
//  HomestayProfileTitle.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfileTitle: View {
    let title: String
    let numOfGuests: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
            Text("\(numOfGuests) guests")
        }.padding(.top, 40)
    }
}
