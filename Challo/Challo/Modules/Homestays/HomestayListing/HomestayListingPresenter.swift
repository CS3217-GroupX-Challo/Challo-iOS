//
//  HomestayListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI
import Combine

class HomestayListingPresenter: ProfilableEntityListingPresenter,
                                SearchableEntityListingPresenter,
                                PriceFilterableEntityListingPresenter {
    typealias Entity = Homestay

    var interactor: HomestayListingInteractor!
    var router: HomestayListingRouter?
    
    var entities: [Homestay] = [] {
        didSet {
            priceFilterPresenter.setSlider(entities: entities)
        }
    }
    
    var isFirstLoad = true
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            if isRefreshing == true {
                interactor.getAllEntities()
            }
        }
    }
    
    var priceFilterPresenter = EntityListingPriceFilterPresenter<Homestay>(getPriceFromEntity: { Int($0.fee) })
    @Published var searchPresenter = EntityListingSearchPresenter<Homestay>(getSearchCriteriaFromEntity: { $0.title })
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        didInitSearchableEntityListingPresenter()
    }
    
    func matchEntityToCardId(entity: Homestay, cardId: String) -> Bool {
        entity.homestayId == UUID(uuidString: cardId)
    }

    var displayedCards: [EntityListingCard] {
        var displayedEntities = searchPresenter.applySearch(entities)
        displayedEntities = priceFilterPresenter.applyFilter(displayedEntities)
        return displayedEntities.map(transformHomestayToCard)
    }

    func transformHomestayToCard(_ homestay: Homestay) -> EntityListingCard {
        EntityListingCard(id: homestay.homestayId.uuidString,
                          entityImage: homestay.images.isEmpty ? nil : homestay.images[0],
                          defaultImage: "mountains-background") {
            AnyView(
                HomestayListingCardDetail(title: homestay.title,
                                          description: homestay.description ?? "",
                                          numberOfBedRoom: homestay.capacity.bedrooms.count,
                                          numberOfBeds: homestay.capacity.bedrooms.map { $0.bedQuantity }.reduce(0, +),
                                          numberOfToilets: homestay.capacity.toilets,
                                          numberOfGuests: homestay.guests,
                                          hasWifi: homestay.amenities.contains(.wifi),
                                          fee: Int(homestay.fee)
                )
            )
        }
    }
}
