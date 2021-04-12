//
//  TrailDifficulty+Color.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

extension TrailDifficulty {
    func getColor() -> Color {
        switch self {
        case .Easy:
            return Color.green
        case .Moderate:
            return Color.orange
        case .Difficult:
            return Color.red
        }
    }
}
