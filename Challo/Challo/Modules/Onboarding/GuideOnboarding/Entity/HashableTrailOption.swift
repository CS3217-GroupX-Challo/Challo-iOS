//
//  HashableTrailOption.swift
//  Challo
//
//  Created by Ying Gao on 14/4/21.
//

import Foundation

struct HashableTrailOption: Identifiable, Hashable {

    let id: UUID
    let name: String

    init(trail: Trail) {
        id = trail.trailId
        name = trail.title
    }
}
