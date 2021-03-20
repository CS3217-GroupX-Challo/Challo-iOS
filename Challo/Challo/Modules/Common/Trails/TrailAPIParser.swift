//
//  TrailsAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//

import Foundation
import MapKit

class TrailAPIParser {

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
              let description = json[Key.description] as? String,
              let positionsJSON = json[Key.positions] as? [JSON],
              let distanceString = json[Key.distance] as? String,
              let areaDetails = json[Key.area] as? JSON,
              let area = areaParser.convertJSONToArea(json: areaDetails) else {
            return nil
        }
        
        let positions = convertJSONToCLLCoordinatesArray(json: positionsJSON)
        
        guard let distance = Double(distanceString) else {
            return nil
        }
        
        var rating: Double = 0
        if let ratingString = json[Key.rating] as? String {
            rating = Double(ratingString) ?? rating
        }
                
        var duration: Double = 0
        if let durationString = json[Key.duration] as? String {
            duration = Double(durationString) ?? duration
        }
        
        var elevation: Double = 0
        if let elevationString = json[Key.elevation] as? String {
            elevation = Double(elevationString) ?? elevation
        }
        
        let images: [String] = json[Key.images] as? [String] ?? []
        
        return Trail(trailId: trailId,
                     title: title,
                     description: description,
                     rating: rating,
                     positions: positions,
                     distance: distance,
                     duration: duration,
                     elevation: elevation,
                     images: images,
                     area: area)
    }
}

extension TrailAPIParser {

    private func convertJSONToCLLCoordinatesArray(json: [JSON]?) -> [CLLocationCoordinate2D] {
        guard let coordinateDetails = json else {
            return []
        }
        
        var coordinates = [CLLocationCoordinate2D]()
        for coordinateDetail in coordinateDetails {
            if let lattitude = coordinateDetail[Key.lattitude] as? Double,
               let longitude = coordinateDetail[Key.longitude] as? Double {
                coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(lattitude),
                                                          longitude: CLLocationDegrees(longitude)))
            }
        }
        return coordinates
    }
}
