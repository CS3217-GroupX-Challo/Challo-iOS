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
    
    func get(url: String,
             headers: HEADER,
             completion: @escaping (JSON, Error?) -> Void) {
        AF.request(url,
                   method: .get,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    let (result, error) = self.grabResponseData(response: response)
                    completion(result, error)
        }
    }
    
    func post(url: String,
              headers: HEADER,
              body: JSON,
              completion: @escaping (JSON, Error?) -> Void) {
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    let (result, error) = self.grabResponseData(response: response)
                    completion(result, error)
        }
    }
    
    func put(url: String,
             headers: HEADER,
             body: JSON,
             completion: @escaping (JSON, Error?) -> Void) {
        AF.request(url,
                   method: .put,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    let (result, error) = self.grabResponseData(response: response)
                    completion(result, error)
        }
    }
    
    func delete(url: String,
                headers: HEADER,
                completion: @escaping (JSON, Error?) -> Void) {
        AF.request(url,
                   method: .delete,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    let (result, error) = self.grabResponseData(response: response)
                    completion(result, error)
        }
    }
    
    private func grabResponseData(response: AFDataResponse<Data>) -> (JSON, Error?) {
        var error: Error?
        guard let data = response.data else {
            return (JSON(), NetworkError.DataError)
            
        }
        
        let serializedData: JSON?
        do {
            serializedData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
        } catch {
            return (JSON(), NetworkError.DataError)
        }
        
        guard let result = serializedData else {
            return (JSON(), error)
        }
        
        guard let status = response.response?.statusCode else {
            return (result, NetworkError.StatusError)
        }
        
        switch status {
        case 403:
            error = NetworkError.RestrictionError
        case 404:
            error = NetworkError.NotFoundError
        case 500:
            error = NetworkError.ServerError
        default:
            error = nil
        }
        
        return (result, error)
    }
}
