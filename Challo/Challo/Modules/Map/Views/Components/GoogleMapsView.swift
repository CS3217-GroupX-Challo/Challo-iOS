//
//  GoogleMapsView.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import GoogleMaps
import CoreLocation
import GoogleMapsUtils

struct GoogleMapsView: UIViewRepresentable {
    
    typealias UIViewType = GMSMapView
        
    private static let defaultCamera = GMSCameraPosition.camera(withLatitude: -37.813_6,
                                                                longitude: 144.963_1,
                                                                zoom: 10.0)
    private let mapView: GMSMapView
    private weak var mapDelegate: GMSMapViewDelegateWrapper?
        
    init() {
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GoogleMapsView.defaultCamera)
        mapView.isMyLocationEnabled = true
        self.mapView = mapView
        let mapDelegateWrapper = GMSMapViewDelegateWrapper()
        self.mapDelegate = mapDelegateWrapper
        self.mapView.delegate = mapDelegateWrapper
    }
        
    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> UIViewType {
        mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: UIViewType, context: Self.Context) {
        
    }
       
    func update(cameraPosition: GMSCameraPosition) -> some View {
        mapView.animate(to: cameraPosition)
        return self
    }
        
    func update(zoom level: Float) -> some View {
        mapView.animate(toZoom: level)
        return self
    }
}
