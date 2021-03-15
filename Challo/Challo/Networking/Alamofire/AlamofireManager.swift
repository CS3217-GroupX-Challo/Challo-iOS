//
//  AlamofireManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

import Alamofire

class AlamofireManager: NetworkManager {
    typealias JSON = [String: Any]
    typealias HEADER = [String: String]
    
    static let alamofireManager = AlamofireManager()
    
    private init() {}
    
    func get(url: String, headers: HEADER) throws -> JSON {
        var responseData = AFResponse(response: nil, data: JSON())
        AF.request(url, method: .get, headers: HTTPHeaders(headers)).responseData { (response) in
            responseData.response = response
        }
        guard let response = responseData.response else {
            throw NetworkError.DataError
        }
        
        return try grabResponseData(response: response)
    }
    
    func post(url: String, headers: HEADER, body: JSON) throws -> JSON {
        return [String: Any]()
    }
    
    func put(url: String, headers: HEADER, body: JSON) throws -> JSON {
        return [String: Any]()
    }
    
    func delete(url: String, headers: HEADER) throws -> JSON {
        return [String: Any]()
    }
    
    private func grabResponseData(response: AFDataResponse<Data>) throws -> JSON {
        guard let status = response.response?.statusCode else {
            throw NetworkError.StatusError
        }
        
        switch status {
        case 200:
            guard let data = response.data else {
                throw NetworkError.DataError
            }
            
            let serializedData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
            guard let result = serializedData else {
                throw NetworkError.DataError
            }
            return result
        case 403:
            throw NetworkError.RestrictionError
        case 404:
            throw NetworkError.NotFoundError
        default:
            throw NetworkError.ServerError
        }
    }
}
