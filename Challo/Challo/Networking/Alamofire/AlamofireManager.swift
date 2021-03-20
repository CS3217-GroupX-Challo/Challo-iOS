//
//  AlamofireManager.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

import Alamofire

class AlamofireManager: NetworkManager {
    typealias JSON = NetworkManager.JSON
    typealias HEADER = NetworkManager.HEADER
    
    static let alamofireManager = AlamofireManager()
    private var apiPath = ProcessInfo.processInfo.environment["api_path"]
    
    private init() {}
    
    func get(url: String,
             headers: HEADER,
             responseHandler: @escaping (JSON, Error?) -> Void) {
        AF.request(concatUrl(url: url),
                   method: .get,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.invokeHandler(response: response,
                                       reponseHandler: responseHandler)
        }
    }
    
    func post(url: String,
              headers: HEADER,
              body: JSON,
              responseHandler: @escaping (JSON, Error?) -> Void) {
        AF.request(concatUrl(url: url),
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.invokeHandler(response: response,
                                       reponseHandler: responseHandler)
        }
    }
    
    func put(url: String,
             headers: HEADER,
             body: JSON,
             responseHandler: @escaping (JSON, Error?) -> Void) {
        AF.request(concatUrl(url: url),
                   method: .put,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.invokeHandler(response: response,
                                       reponseHandler: responseHandler)
        }
    }
    
    func delete(url: String,
                headers: HEADER,
                responseHandler: @escaping (JSON, Error?) -> Void) {
        AF.request(concatUrl(url: url),
                   method: .delete,
                   headers: HTTPHeaders(headers)).responseData { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    self.invokeHandler(response: response,
                                       reponseHandler: responseHandler)
        }
    }
    
    private func invokeHandler(response: AFDataResponse<Data>,
                               reponseHandler: @escaping (JSON, Error?) -> Void) {
        let (result, error) = self.grabResponseData(response: response)
        reponseHandler(result, error)
    }
    
    private func concatUrl(url: String) -> String {
        guard let path = apiPath else {
            fatalError("Environment variable not set up correctly")
        }
        return path + url
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
