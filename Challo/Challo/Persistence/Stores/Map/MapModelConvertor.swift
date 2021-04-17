//
//  MapModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import Foundation

// MARK: - MapMarker conversion
class MapModelConvertor {
    func convertMapMarkerToMarkerPersistenceObject(mapMarker: MapMarker) -> MarkerPersistenceObject {
        MarkerPersistenceObject(id: mapMarker.id,
                                position: mapMarker.position,
                                date: mapMarker.date,
                                comments: mapMarker.comments)
    }
    
    func convertMarkerPersistenceObjectToMapMarker(markerObject: MarkerPersistenceObject) -> MapMarker {
        MapMarker(id: markerObject.id,
                  position: markerObject.position,
                  date: markerObject.date,
                  comments: markerObject.comments)
    }
}

// MARK: - MapRoute Conversion
extension MapModelConvertor {
    func convertMapRouteToRoutePersistenceObject(mapRoute: MapRoute) -> RoutePersistenceObject {
        RoutePersistenceObject(id: mapRoute.id,
                               start: convertMapMarkerToMarkerPersistenceObject(mapMarker: mapRoute.start),
                               end: convertMapMarkerToMarkerPersistenceObject(mapMarker: mapRoute.end),
                               date: mapRoute.date,
                               comments: mapRoute.comments)
    }
    
    func convertRoutePersistenceObjectToMapRoute(routeObject: RoutePersistenceObject) -> MapRoute {
        MapRoute(id: routeObject.id,
                 start: convertMarkerPersistenceObjectToMapMarker(markerObject: routeObject.start),
                 end: convertMarkerPersistenceObjectToMapMarker(markerObject: routeObject.end),
                 date: routeObject.date,
                 comments: routeObject.comments)
    }
}

// MARK: - MapItinerary conversion
extension MapModelConvertor {
    func convertMapItineraryToItineraryPersistenceObject(mapIitnerary: MapItinerary) -> ItineraryPersistenceObject {
        let markers = mapIitnerary.markers.map { mapMarker in
            convertMapMarkerToMarkerPersistenceObject(mapMarker: mapMarker)
        }
        
        let routes = mapIitnerary.routes.map { mapRoute in
            convertMapRouteToRoutePersistenceObject(mapRoute: mapRoute)
        }
        
        return ItineraryPersistenceObject(id: mapIitnerary.id,
                                          routes: routes,
                                          markers: markers,
                                          title: mapIitnerary.title,
                                          createdAt: mapIitnerary.createdAt,
                                          lastModified: mapIitnerary.lastModified)
    }
    
    func convertItineraryPersistenceObjectToMapItinerary(itineraryObject: ItineraryPersistenceObject) -> MapItinerary {
        let mapMarkers = itineraryObject.markers.map { marker in
            convertMarkerPersistenceObjectToMapMarker(markerObject: marker)
        }
        
        let mapRoutes = itineraryObject.routes.map { route in
            convertRoutePersistenceObjectToMapRoute(routeObject: route)
        }
        
        return MapItinerary(id: itineraryObject.id,
                            routes: mapRoutes,
                            markers: mapMarkers,
                            title: itineraryObject.title,
                            createdAt: itineraryObject.createdAt,
                            lastModified: itineraryObject.lastModified)
    }
}
