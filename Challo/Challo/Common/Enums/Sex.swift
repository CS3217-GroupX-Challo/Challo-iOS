//
//  Sex.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

enum Sex: String, CaseIterable {
    case Male, Female
    
    static func convertToSex(from sexString: String) -> Sex? {
        if sexString == "male" {
            return Sex.Male
        } else if sexString == "female" {
            return Sex.Female
        } else {
            return nil
        }
    }
}
