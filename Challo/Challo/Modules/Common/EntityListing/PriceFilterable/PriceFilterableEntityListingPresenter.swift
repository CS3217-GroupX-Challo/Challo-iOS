//
//  PriceFilterableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import Combine

/// A presenter which allows for filtering of entities by price
protocol PriceFilterableEntityListingPresenter: SearchableEntityListingPresenter {
    associatedtype Entity
    var priceFilterPresenter: EntityListingPriceFilterPresenter<Entity> { get }
}

extension PriceFilterableEntityListingPresenter {
    var slider: CustomSlider {
        priceFilterPresenter.slider
    }
}
