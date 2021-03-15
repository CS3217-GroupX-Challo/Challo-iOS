//
//  NetworkManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

protocol NetworkManager {
    typealias JSON = [String: Any] // emulate JSON objects to make it extensible
    typealias HEADER = [String: String]
    
    func get(url: String, headers: HEADER) throws -> JSON
    func post(url: String, headers: HEADER, body: JSON) throws -> JSON
    func put(url: String, headers: HEADER, body: JSON) throws -> JSON
    func delete(url: String, headers: HEADER) throws -> JSON
}
