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
             completion: @escaping (JSON) -> Void,
             errorHandling: @escaping (Error) -> Void) {
        AF.request(url,
                   method: .get,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.handleClosures(response: response,
                                        completion: completion,
                                        errorHandling: errorHandling)
        }
    }
    
    func post(url: String,
              headers: HEADER,
              body: JSON,
              completion: @escaping (JSON) -> Void,
              errorHandling: @escaping (Error) -> Void) {
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.handleClosures(response: response,
                                        completion: completion,
                                        errorHandling: errorHandling)
        }
    }
    
    func put(url: String,
             headers: HEADER,
             body: JSON,
             completion: @escaping (JSON) -> Void,
             errorHandling: @escaping (Error) -> Void) {
        AF.request(url,
                   method: .put,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.handleClosures(response: response,
                                        completion: completion,
                                        errorHandling: errorHandling)
        }
    }
    
    func delete(url: String,
                headers: HEADER,
                completion: @escaping (JSON) -> Void,
                errorHandling: @escaping (Error) -> Void) {
        AF.request(url,
                   method: .delete,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.handleClosures(response: response,
                                        completion: completion,
                                        errorHandling: errorHandling)
        }
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
    
    private func handleClosures(response: AFDataResponse<Data>,
                                completion: @escaping (JSON) -> Void,
                                errorHandling: @escaping (Error) -> Void) {
        do {
            let data = try grabResponseData(response: response)
            completion(data)
        } catch {
            errorHandling(error)
        }
    }
}
