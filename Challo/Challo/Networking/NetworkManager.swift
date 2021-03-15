//
//  NetworkManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

protocol NetworkManager {
    typealias JSON = [String: Any] // emulate JSON objects to make it extensible
    typealias HEADER = [String: String]
    
    func get(url: String,
             headers: HEADER,
             responseHandler: @escaping (JSON, Error?) -> Void)
    
    func post(url: String,
              headers: HEADER,
              body: JSON,
              responseHandler: @escaping (JSON, Error?) -> Void)
    
    func put(url: String,
             headers: HEADER,
             body: JSON,
             responseHandler: @escaping (JSON, Error?) -> Void)
    
    func delete(url: String,
                headers: HEADER,
                responseHandler: @escaping (JSON, Error?) -> Void)
}
