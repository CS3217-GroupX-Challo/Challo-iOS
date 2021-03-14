//
//  NetworkError.swift
//  Challo
//
//  Created by Kester Ng on 15/3/21.
//

enum NetworkError: Error {
    case NotFoundError // 404
    case ServerError // 500
    case RestrictionError // 403
}
