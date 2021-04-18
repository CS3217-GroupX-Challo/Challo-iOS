//
//  Days.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

enum Days: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

extension Days: Identifiable {
    var id: String {
        rawValue
    }
}
