//
//  ReviewStore.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

class ReviewStore {
    private let reviewModelConvertor: ReviewModelConvertor
    private let reviewRepository: ReviewDetailsRepositoryProtocol
    
    init(reviewModelConvertor: ReviewModelConvertor,
         reviewRepository: ReviewDetailsRepositoryProtocol) {
        self.reviewModelConvertor = reviewModelConvertor
        self.reviewRepository = reviewRepository
    }
    
    func getAllReviews() -> [Review] {
        let reviewObjects = reviewRepository.getAllReviews()
        return reviewObjects.map { reviewObject in
            reviewModelConvertor.convertPersistenceObjectToModel(object: reviewObject)
        }
    }
    
    func saveReviews(reviews: [Review]) {
        let reviewObjects = reviews.map { review in
            reviewModelConvertor.convertModelToPersistenceObject(model: review)
        }
        
        reviewRepository.saveReviews(reviewObjects: reviewObjects)
    }
}
