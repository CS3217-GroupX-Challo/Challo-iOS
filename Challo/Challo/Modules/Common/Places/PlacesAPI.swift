//
//  PlacesAPI.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import Foundation

class PlacesAPI: PlacesAPIProtocol {
    
    private let parser: PlacesAPIParser
    private let networkManager: NetworkManager
    
    private let urlEnd: String = "&inputtype=textquery&fields=formatted_address,name,rating,opening_hours,geometry&key="
    
    init(parser: PlacesAPIParser, networkManager: NetworkManager) {
        self.parser = parser
        self.networkManager = networkManager
    }
    
    func getPlaces(with name: String, callback: @escaping ([Place]) -> Void) {
        let url = getUrl(name: name)
        networkManager.get(url: url,
                           headers: [String: String]()) { [weak self] response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            let places: [Place] = self.parser.parsePlaces(response: response)
            callback(places)
        }
    }
    
    // Construct google places search query
    private func getUrl(name: String) -> String {
        let words = name.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        var url = ""
        
        for i in 0..<words.count {
            let word = words[i]
            
            if i != words.count - 1 {
                url += word + "%20"
            } else {
                url += word
            }
        }
        
        let googleApiKey = ProcessInfo.processInfo.environment["google_maps_api_key"] ?? ""
        return url + urlEnd + googleApiKey
    }
}
