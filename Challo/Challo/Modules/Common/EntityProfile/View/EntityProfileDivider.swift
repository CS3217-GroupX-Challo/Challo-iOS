//
//  EntityProfileDivider.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct EntityProfileDivider: View {
    var standardEdgeInset: EdgeInsets {
        EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
    }
    
    var body: some View {
        Divider().padding(standardEdgeInset)
    }
}
