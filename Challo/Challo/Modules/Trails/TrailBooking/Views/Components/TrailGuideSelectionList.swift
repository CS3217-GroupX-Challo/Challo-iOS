//
//  TrailGuideSelectionList.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import SwiftUI

struct TrailGuideSelectionList: View {
    
    @Binding var guides: [Guide]
    @Binding var selectedGuideId: UUID?
    var cardWidth: CGFloat
    var cardHeight: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select your guide")
                .foregroundColor(.themeTertiary)
            if guides.isEmpty {
                Text("No guides are available on your selected date, please choose another date!")
                    .padding()
                    .foregroundColor(.themeForeground)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(guides, id: \.userId) { guide in
                            TrailGuideSelectionCard(guide: guide,
                                                    width: cardWidth,
                                                    height: cardHeight,
                                                    selected: selectedGuideId == guide.userId)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            selectedGuideId = guide.userId
                                        }
                                )
                        }
                    }
                }
            }
        }
    }
}
