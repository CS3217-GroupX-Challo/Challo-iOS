//
//  TrailGuideSelectionList.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import SwiftUI

struct TrailGuideSelectionList: View {
    
    @Binding var guides: [Guide]
    @Binding var selectedIndex: Int?

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(guides.indices) { index in
                    TrailGuideSelectionCard(guide: guides[index], width: 300, height: 300)
                }
            }
        }
    }
}
