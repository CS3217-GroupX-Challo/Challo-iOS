//
//  String+ConstructDestructArray.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

extension String {
    init(array: [String]) {
        let str = array.joined(separator: ", ")
        self.init(str)
    }
    
    func constructArray() -> [String] {
        self.components(separatedBy: ", ")
    }
}
