//
//  AlamofireManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

import Alamofire

struct AlamofireManager: NetworkManager {
    func get(url: String, headers: JSON) throws -> JSON {
        return [String: Any]()
    }
    
    func post(url: String, headers: JSON, body: JSON) throws -> JSON {
        return [String: Any]()
    }
    
    func put(url: String, headers: JSON, body: JSON) throws -> JSON {
        return [String: Any]()
    }
    
    func delete(url: String, headers: JSON) throws -> JSON {
        return [String: Any]()
    }
}
