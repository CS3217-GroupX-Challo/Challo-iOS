//
//  Languages.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

enum Languages: String, CaseIterable {
    case English
    case Hindi
}

extension Languages: Identifiable {
    var id: String {
        rawValue
    }
}
