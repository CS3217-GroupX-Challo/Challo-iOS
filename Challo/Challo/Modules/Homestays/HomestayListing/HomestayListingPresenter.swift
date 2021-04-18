//
//  HomestayListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

class HomestayListingPresenter: EntityListingPresenter,
                                SearchableEntityListingPresenter,
                                ObservableObject {

    var interactor: HomestayListingInteractor!
    var router: HomestayListingRouter?
    
    var entities: [Homestay] = [] {
        didSet {
//            setSlider()
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
    
    @Published var searchBarText: String = ""
    @Published var isSearchBarSheetOpen: Bool = false
    
    @Published var searchPresenter = EntityListingSearchPresenter<Homestay>(getSearchCriteriaFromEntity: { $0.title })
    
    func getEntityByCardId(_ cardId: String) -> Homestay {
        guard let homestay = entities.first(where: { $0.homestayId == UUID(uuidString: cardId) }) else {
            fatalError("homestays is not synced with cards")
        }
        return homestay
    }

    var displayedCards: [ListingCard] {
        let displayedEntities = searchPresenter.applySearch(entities)
        return displayedEntities.map(transformHomestayToCard)
    }

    func transformHomestayToCard(_ homestay: Homestay) -> ListingCard {
        ListingCard(id: homestay.homestayId.uuidString,
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
