//
//  AFResponse.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

import Alamofire

struct AFResponse {
    typealias JSON = [String: Any]
    var response: AFDataResponse<Data>?
    var data: JSON
}
