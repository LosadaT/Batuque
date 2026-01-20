//
//  SwiftUIView.swift
//  Batuque
//
//  Created by Francisco Losada on 20/01/26.
//

import SwiftUI
import MapKit

struct BrazilMapView: UIViewRepresentable {
    @EnvironmentObject var mapVM: MapViewModel
    @Binding var stateSelected: Zone?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = mapVM.mkMapView
        mapView.delegate = context.coordinator
        //        mapView.region = MKCoordinateRegion(
        //            center: CLLocationCoordinate2D(latitude: 40.8522, longitude: 14.265),
        //            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //        )
        mapView.mapType = .mutedStandard
        mapView.pointOfInterestFilter = .excludingAll
        //mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 10000000, maxCenterCoordinateDistance: 10000000)
        mapView.isRotateEnabled = false
        
        for zone in mapVM.brazil {
            let polygon = MKPolygon(coordinates: zone.coordinates, count: zone.coordinates.count)
            mapView.addOverlay(polygon)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: BrazilMapView
        
        init(_ parent: BrazilMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygonOverlay = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygonOverlay)
                renderer.fillColor = UIColor.gray.withAlphaComponent(0.1)
                renderer.strokeColor = UIColor.gray
                renderer.lineWidth = 1
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
