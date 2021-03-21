//
//  String+WhiteSpaceCheck.swift
//  Challo
//
//  Created by Ying Gao on 21/3/21.
//

extension String {

    var isEmptyOrOnlyWhiteSpace: Bool {
        range(of: "\\S+", options: .regularExpression) == nil
    }

}
