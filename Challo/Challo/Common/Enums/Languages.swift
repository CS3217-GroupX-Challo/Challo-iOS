//
//  Languages.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

enum Languages: String, CaseIterable {
    case English
    case Hindi
    case Bengali
    case Marathi
    case Urdu
    case Gujarati
    case Punjabi
    case Kashmiri
    case Rajasthani
    case Sindhi
    case Assamese
    case Maithili
    case Odia
}

extension Languages: Identifiable {
    var id: String {
        rawValue
    }
}
