//
//  InteractiveMapPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 15.0
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        
    }
}

struct InteractiveMapPage: View {
    var body: some View {
        GoogleMapsView()
            .edgesIgnoringSafeArea(.all)
    }
}
