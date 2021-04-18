//
//  Amenities.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

/// Represents the amenities a homestay could have
enum Amenity: String {
    case essentials = "Essentials"
    case wifi = "Wifi"
    case kitchen = "Kitchen"
    case freeParking = "Free Parking"
    case tv = "TV"
    case hotWater = "Hot Water"
    case heating = "Heating"
    case airCon = "Air Conditioning"
    case washingMachine = "Washing Machine"
    case dryer = "Dryer"
    case iron = "Iron"
    case shampoo = "Shampoo"
    case hairDryer = "Hair Dryer"
    case hotTub = "Hot Tub"
    case pool = "Pool"
    case breakfast = "Breakfast"
    case gym = "Gym"
    case dedicatedWorkspace = "Dedicated Workspace"
    case lift = "Lift"
    case indoorFireplace = "Indoor Fireplace"
    case hangers = "Hangers"
    case smokeAlarm = "Smoke Alarm"
    case carbonMonoxideAlarm = "Carbon Monoxide Alarm"
    case firstAidKit = "First Aid Kit"
    case fireExtinguisher = "Fire Extinguisher"
    case lock = "Lock"
    
    // swiftlint:disable cyclomatic_complexity
    func getIcon() -> String {
        switch self {
        case .essentials:
            return "staroflife.circle.fill"
        case .wifi:
            return "wifi"
        case .freeParking:
            return "car.2"
        case .tv:
            return "tv"
        case .hotWater:
            return "drop.fill"
        case .heating:
            return "thermometer.sun"
        case .airCon:
            return "thermometer.snowflake"
        case .washingMachine:
            return "sparkles"
        case .dryer:
            return "wind"
        case .firstAidKit:
            return "cross.case.fill"
        case .fireExtinguisher:
            return "flame.fill"
        case .lock:
            return "lock.fill"
        case .smokeAlarm:
            return "smoke.fill"
        case .breakfast:
            return "leaf.fill"
        case .shampoo:
            return "aqi.medium"
        case .iron:
            return "sparkle"
        default:
            return "lasso.sparkles"
        }
    }
}
