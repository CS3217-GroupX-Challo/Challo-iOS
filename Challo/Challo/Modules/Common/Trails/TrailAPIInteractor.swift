//
//  TrailsAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//

import Foundation
import MapKit

protocol TrailAPIInteractor: AreaAPIInteractor {
    typealias JSON = AlamofireManager.JSON
    
    func parseTrail(response: JSON) -> [Trail]
}

extension TrailAPIInteractor {
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
              let area = self.convertJSONToArea(json: areaDetails) else {
            return nil
        }
        
        let positions = convertJSONToCLLCoordinatesArray(json: positionsJSON)
        guard let distance = Decimal(string: distanceString) else {
            return nil
        }
                
        var duration = Decimal(0)
        if let durationString = json[Key.duration] as? String {
            duration = Decimal(string: durationString) ?? Decimal(0)
        }
        
        var elevation = Decimal(0)
        if let elevationString = json[Key.elevation] as? String {
            elevation = Decimal(string: elevationString) ?? Decimal(0)
        }
        
        let images: [String] = json[Key.images] as? [String] ?? []
        
        return Trail(trailId: trailId,
                     title: title,
                     description: description,
                     positions: positions,
                     distance: distance,
                     duration: duration,
                     elevation: elevation,
                     images: images,
                     area: area)
    }
    
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
