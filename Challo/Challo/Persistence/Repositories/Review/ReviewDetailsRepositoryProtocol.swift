//
//  ReviewDetailsRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

protocol ReviewDetailsRepositoryProtocol {
    func getAllReviews() -> [ReviewPersistenceObject]
    func saveReviews(reviewObjects: [ReviewPersistenceObject])
}
