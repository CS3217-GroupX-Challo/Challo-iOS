//
//  PriceFilterableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import Combine

protocol PriceFilterableEntityListingPresenter: ObservableObject {
    associatedtype Entity
    var priceFilterPresenter: EntityListingPriceFilterPresenter<Entity> { get }
}

extension PriceFilterableEntityListingPresenter {
    var slider: CustomSlider {
        priceFilterPresenter.slider
    }
}
