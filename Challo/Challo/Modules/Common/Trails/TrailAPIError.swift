//
//  TrailAPIError.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

enum TrailAPIError: Error {
    case failedToParse(json: [String: Any])
}
