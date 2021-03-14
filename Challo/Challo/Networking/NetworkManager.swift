//
//  NetworkManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

protocol NetworkManager {
    typealias JSON = [String: Any] // emulate JSON objects to make it extensible
    
    func get(url: String, headers: JSON) throws -> JSON
    func post(url: String, headers: JSON, body: JSON) throws -> JSON
    func put(url: String, headers: JSON, body: JSON) throws -> JSON
    func delete(url: String, headers: JSON) throws -> JSON
}
