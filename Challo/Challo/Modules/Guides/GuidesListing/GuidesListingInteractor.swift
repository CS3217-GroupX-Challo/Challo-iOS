//
//  GuidesListingInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import Foundation

class GuidesListingInteractor: EntityListingInteractor {
    
    typealias Entity = Guide
    
    weak var presenter: GuidesListingPresenter!
    
    var repository: Repository<UUID, Guide> & FetchableRepository
    
    init(guideRepository: GuideRepositoryProtocol) {
        self.repository = guideRepository
    }
}
