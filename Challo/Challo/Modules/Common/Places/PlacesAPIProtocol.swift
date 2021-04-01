//
//  PlacesAPIProtocol.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

protocol PlacesAPIProtocol: APIProtocol {
    func getPlaces(with name: String, callback: @escaping ([Place]) -> Void)
}
