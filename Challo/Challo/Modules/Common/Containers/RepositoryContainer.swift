//
//  RepositoryContainer.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Swinject

class RepositoryContainer {
    weak var apiContainer: APIContainer?
    let container = Container()
    
    init(apiContainer: APIContainer) {
        self.apiContainer = apiContainer
        registerRepositories()
    }
    
    private func registerRepositories() {
        container.register(TrailRepositoryProtocol.self) { [weak self] _ in
            guard let trailAPI = self?.apiContainer?.container.resolve(TrailAPIProtocol.self) else {
                fatalError("Failed to resolve TrailAPIProtocol in RepositoryContainer")
            }
            guard let trailStore = self?.getTrailStore() else {
                fatalError("Fail to construct trailStore")
            }
            return TrailRepository(trailAPI: trailAPI, trailStore: trailStore)
        }
        container.register(AreaRepositoryProtocol.self) { [weak self] _ in
            guard let areaAPI = self?.apiContainer?.container.resolve(AreaAPIProtocol.self) else {
                fatalError("Failed to resolve AreaAPIProtocol in RepositoryContainer")
            }
            return AreaRepository(areaAPI: areaAPI)
        }
        container.register(GuideRepositoryProtocol.self) { [weak self] _ in
            guard let guideAPI = self?.apiContainer?.container.resolve(GuideAPIProtocol.self) else {
                fatalError("Failed to resolve GuideAPIProtocol in RepositoryContainer")
            }
            guard let guideStore = self?.getGuideStore() else {
                fatalError("Failed to construct guideStore")
            }
            return GuideRepository(guideAPI: guideAPI, guideStore: guideStore)
        }
        container.register(BookingRepositoryProtocol.self) { [weak self] _ in
            guard let bookingAPI = self?.apiContainer?.container.resolve(BookingAPIProtocol.self) else {
                fatalError("Failed to resolve BookingAPIProtocol in RepositoryContainer")
            }
            guard let bookingStore = self?.getBookingStore() else {
                fatalError("Failed to construct bookingStore")
            }
            return BookingRepository(bookingAPI: bookingAPI, bookingStore: bookingStore)
        }
    }

    private func getGuideStore() -> GuideStore {
        let areaModelConvertor = AreaModelConvertor()
        let guideModelConvertor = GuideModelConvertor(areaModelConvertor: areaModelConvertor,
                                                      trailModelConvertor: TrailModelConvertor(convertor:
                                                                                                areaModelConvertor))
        
        let guideDetailsRepo = AnyPersistenceRepoProtocol(GuideDetailsRepository())
        return GuideStore(repository: guideDetailsRepo, convertor: guideModelConvertor)
    }

    private func getTrailStore() -> TrailStore {
        let trailModelConvertor = TrailModelConvertor(convertor: AreaModelConvertor())
        
        let trailDetailsRepo = AnyPersistenceRepoProtocol(TrailDetailsRepository())
        return TrailStore(repository: trailDetailsRepo, convertor: trailModelConvertor)
    }

    private func getBookingStore() -> BookingStore {
        let areaModelConvertor = AreaModelConvertor()
        let trailModelConvertor = TrailModelConvertor(convertor: areaModelConvertor)
        let guideModelConvertor = GuideModelConvertor(areaModelConvertor: areaModelConvertor,
                                                      trailModelConvertor: trailModelConvertor)
        let reviewModelConvertor = ReviewModelConvertor(guideModelConvertor: guideModelConvertor,
                                                        touristModelConvertor: TouristModelConvertor(),
                                                        trailModelConvertor: trailModelConvertor)
        let bookingModelConvertor = BookingModelConvertor(trailModelConvertor: trailModelConvertor,
                                                          guideModelConvertor: guideModelConvertor,
                                                          touristModelConvertor: TouristModelConvertor(),
                                                          reviewModelConvertor: reviewModelConvertor)
        
        let bookingDetailsRepo = AnyPersistenceRepoProtocol(BookingInfoRepository())
        return BookingStore(repository: bookingDetailsRepo, convertor: bookingModelConvertor)
    }
}
