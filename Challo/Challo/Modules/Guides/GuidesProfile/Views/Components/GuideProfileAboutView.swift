//
//  GuideProfileAboutView.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct GuideProfileAboutView: View {
    let biography: String?
    let languages: String
    let accreditations: [String]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "text.quote")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.themeTertiary)
            Text(biography ?? "")
            HStack(spacing: 10) {
                Image(systemName: "message.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color.themeTertiary)
                Text("Speaks \(languages)")
                    .font(.caption)
            }
            if let accreditations = accreditations {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(Color.themeTertiary)
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(accreditations, id: \.self) { accredit in
                            Text(accredit)
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
}
