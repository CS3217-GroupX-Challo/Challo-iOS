//
//  AreaAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol AreaAPIProtocol: APIProtocol {
    func getAreas(url: String, callback: @escaping ([Area]) -> Void)
}

extension AreaAPIProtocol {
    func getAreas(url: String = "/area", callback: @escaping ([Area]) -> Void) {
        getAreas(url: url, callback: callback)
    }
}
