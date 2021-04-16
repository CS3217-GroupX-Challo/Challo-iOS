//
//  Key.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//

/// Contains all API-Response keys
struct Key {
    static let areaId = "areaId"
    static let country = "country"
    static let division = "division"
    static let state = "state"
    static let village = "village"
    static let userId = "userId"
    static let email = "email"
    static let password = "password"
    static let token = "token"
    static let data = "data"
    static let daysAvailable = "daysAvailable"
    static let sex = "sex"
    static let area = "area"
    static let profileImage = "profileImg"
    static let name = "name"
    static let nickname = "nickname"
    static let phone = "phone"
    static let dateJoined = "dateJoined"
    static let unavailableDates = "unavailableDates"
    static let dateOfBirth = "dateOfBirth"
    static let yearsOfExperience = "yearsOfExperience"
    static let languages = "languages"
    static let accreditations = "accreditations"
    static let biography = "biography"
    static let trailId = "trailId"
    static let images = "images"
    static let tags = "tags"
    static let landmarks = "landmarks"
    static let bookingId = "bookingId"
    static let fee = "fee"
    static let date = "date"
    static let status = "status"
    static let lowestFee = "lowestFee"
    static let title = "title"
    static let description = "description"
    static let positions = "positions"
    static let distance = "distance"
    static let duration = "duration"
    static let elevation = "elevation"
    static let lattitude = "lattitude"
    static let longitude = "longitude"
    static let numOfReviews = "numOfReviews"
    static let memorableExperiences = "memorableExperiences"
    static let hobbies = "hobbies"
    static let reviewId = "reviewId"
    static let rating = "rating"
    static let comment = "comment"
    static let guideId = "guideId"
    static let touristId = "touristId"
    static let createdAt = "createdAt"
    static let activeSince = "activeSince"
    static let guide = "guide"
    static let tourist = "tourist"
    static let trail = "trail"
    static let difficulty = "difficulty"
}

// MARK: Facebook API-Response keys
extension Key {
    static let fbName = "name"
    static let fbEmail = "email"
    static let fbId = "id"
}

// MARK: Google Places response keys
extension Key {
    static let googleLatitude = "lat"
    static let googleLongitude = "lng"
    static let googleName = "name"
    static let googleAddress = "formatted_address"
    static let googleOpeningHours = "opening_hours"
    static let googleOpenNow = "open_now"
    static let googleRating = "rating"
    static let googleGeometry = "geometry"
    static let googleLocation = "location"
}

// MARK: Homestays
extension Key {
    static let homestayId = "homestayId"
    static let imagesPath = "imagesPath"
    static let location = "location"
    static let capacity = "capacity"
    static let bedrooms = "bedrooms"
    static let bed = "bed"
    static let quantity = "quantity"
    static let toilets = "toilets"
    static let amenities = "amenities"
    static let guests = "guests"
}
