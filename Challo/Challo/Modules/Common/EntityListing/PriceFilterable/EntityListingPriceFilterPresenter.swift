//
//  EntityListingPriceFilterPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

/// A helper lass that encapsulates filtering of entities by their prices
class EntityListingPriceFilterPresenter<Entity> {
    
    @Published var slider = CustomSlider(width: 600, start: 0, end: 0)
    
    let getPriceFromEntity: (Entity) -> Int
    
    init(getPriceFromEntity: @escaping (Entity) -> Int) {
        self.getPriceFromEntity = getPriceFromEntity
    }
    
    private let offset: Int = 100
    
    private var lowestTrailPrice: Int = .min
    private var highestTrailPrice: Int = .max
    
    private var priceFilterLowerBound: Int {
        Int(floor(slider.lowHandle.currentValue))
    }
    
    private var priceFilterUpperBound: Int {
        Int(ceil(slider.highHandle.currentValue))
    }
    
    /// Given a list of entities, filters according to the selected price range
    func applyFilter(_ entities: [Entity]) -> [Entity] {
        entities.filter { getPriceFromEntity($0) >= priceFilterLowerBound &&
            getPriceFromEntity($0) <= priceFilterUpperBound
        }
    }
    
    /// Sets the slider's min and max value according to the list of entities shown
    func setSlider(entities: [Entity]) {
        lowestTrailPrice = (entities.map { getPriceFromEntity($0) }.min() ?? .min + offset) - offset
        highestTrailPrice = (entities.map { getPriceFromEntity($0) }.max() ?? .max - offset) + offset
        slider = CustomSlider(width: 600, start: Double(lowestTrailPrice), end: Double(highestTrailPrice))
    }
    
}
