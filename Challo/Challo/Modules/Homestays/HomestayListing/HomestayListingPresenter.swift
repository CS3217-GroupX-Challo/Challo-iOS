//
//  HomestayListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI
import Combine

final class HomestayListingPresenter: ProfilableEntityListingPresenter,
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
            refresh()
        }
    }
    
    var priceFilterPresenter = EntityListingPriceFilterPresenter<Homestay>(getPriceFromEntity: { Int($0.fee) })
    @Published var searchPresenter: EntityListingSearchPresenter<Homestay>!
        
    init() {
        searchPresenter = EntityListingSearchPresenter<Homestay>(
            presenterWillChange: {
                [weak self] in self?.objectWillChange.send()
            }) {
                $0.title
        }
    }
    
    func matchEntityToCardId(entity: Homestay, cardId: String) -> Bool {
        entity.homestayId == UUID(uuidString: cardId)
    }

    var displayedCards: [EntityListingCard] {
        var displayedEntities = searchPresenter.applySearch(entities)
        displayedEntities = priceFilterPresenter.applyFilter(displayedEntities)
        displayedEntities.sort {
            $0.title < $1.title
        }
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
