//
//  CaseIterable+ParseString.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

extension CaseIterable {
    static func parseString(_ string: String, caseInsensitive: Bool = false) -> Self? {
        let formattedString = caseInsensitive ? string.lowercased() : string
        return Self.allCases.first { formattedString == "\($0)".lowercased() }
    }
}
