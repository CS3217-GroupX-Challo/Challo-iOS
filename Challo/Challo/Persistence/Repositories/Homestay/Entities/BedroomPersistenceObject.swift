//
//  BedroomPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 18/4/21.
//

struct BedroomPersistenceObject {
    let bed: Bed
    let bedQuantity: Int
    
    func convertToString() -> String {
        "\(bed.rawValue)+\(bedQuantity)"
    }
}
