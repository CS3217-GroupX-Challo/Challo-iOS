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
            return TrailRepository(trailAPI: trailAPI)
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
            return GuideRepository(guideAPI: guideAPI)
        }
        container.register(BookingRepositoryProtocol.self) { [weak self] _ in
            guard let bookingAPI = self?.apiContainer?.container.resolve(BookingAPIProtocol.self) else {
                fatalError("Failed to resolve BookingAPIProtocol in RepositoryContainer")
            }
            return BookingRepository(bookingAPI: bookingAPI)
        }
    }
}
