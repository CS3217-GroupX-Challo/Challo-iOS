//
//  Bed.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

/// Represents the different types of beds a homestay could have
enum Bed: String {
    case king = "King"
    case queen = "Queen"
    case double = "Double"
    case single = "Single"
    case sofaBed = "Sofa Bed"
    case sofa = "Sofa"
    case airBed = "Airbed"
    case bunkBed = "Bunk Bed"
    case floorMattress = "Floor Mattress"
    case toddlerBed = "Toddler Bed"
    case cot = "Cot"
    case waterBed = "Water Bed"
    case hammock = "Hammock"
    
    func getIcon() -> String {
        switch self {
        case .king:
            return "person.3.fill"
        case .double:
            return "person.2.fill"
        case .single:
            return "person"
        default:
            return "person"
        }
    }
}
