//
//  TrailsAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//
import Foundation
import MapKit

class TrailAPIParser: AreaAPIParser {

    typealias JSON = NetworkManager.JSON
    let areaParser = AreaAPIParser()

    func parseTrail(response: JSON) -> [Trail] {
        guard let data = response["data"],
              let trailsInfo = data as? [JSON] else {
            return []
        }
        
        var trails: [Trail] = []
        for trailInfo in trailsInfo {
            if let trail = convertJSONToTrail(json: trailInfo) {
                trails.append(trail)
            }
        }
        return trails
    }

    func convertJSONToTrail(json: JSON) -> Trail? {
        
        guard let trailId = UUID(uuidString: json[Key.trailId] as? String ?? ""),
              let title = json[Key.title] as? String,
              let difficultyString = json[Key.difficulty] as? String,
              let difficulty = TrailDifficulty.parseString(difficultyString, caseInsensitive: true),
              let distanceJSONValue = json[Key.distance],
              let description = json[Key.description] as? String,
              let positionsJSON = json[Key.positions] as? [JSON],
              let areaDetails = json[Key.area] as? JSON,
              let area = self.convertJSONToArea(json: areaDetails) else {
            return nil
        }
        
        let positions = convertJSONToCLLCoordinatesArray(json: positionsJSON)
        let distance = convertJSONDoubleValueToDouble(distanceJSONValue)
        let rating = convertJSONDoubleValueToDouble(json[Key.rating])
        let duration = convertJSONDoubleValueToDouble(json[Key.duration])
        let elevation = convertJSONDoubleValueToDouble(json[Key.elevation])
        let numOfReviews = convertJSONIntValueToInt(json[Key.numOfReviews])
        let images: [String] = json[Key.images] as? [String] ?? []
        let tags: [String] = json[Key.tags] as? [String] ?? []
        let landmarks: [String] = json[Key.landmarks] as? [String] ?? []
        let lowestFee = convertJSONIntValueToInt(json[Key.lowestFee])

        return Trail(trailId: trailId,
                     title: title,
                     description: description,
                     rating: rating,
                     difficulty: difficulty,
                     positions: positions,
                     distance: distance,
                     duration: duration,
                     elevation: elevation,
                     images: images,
                     area: area,
                     numOfReviews: numOfReviews,
                     lowestFee: lowestFee,
                     tags: tags,
                     landmarks: landmarks)
    }
}

extension TrailAPIParser {

    private func convertJSONToCLLCoordinatesArray(json: [JSON]?) -> [CLLocationCoordinate2D] {
        guard let coordinateDetails = json else {
            return []
        }
        
        var coordinates = [CLLocationCoordinate2D]()
        for coordinateDetail in coordinateDetails {
            if let coordinate = convertJSONLocationToCLLocation2D(coordinateDetail) {
                coordinates.append(coordinate)
            }
        }
        return coordinates
    }
}
