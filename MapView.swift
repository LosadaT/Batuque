import SwiftUI
import MapKit

//struct MapView: UIViewRepresentable {
//    let eventData = MapDataSource()
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView(frame: .zero)
//        mapView.delegate = context.coordinator
//        mapView.addOverlays(eventData.overlays, level: .aboveRoads)
//
//        if let firstOverlay = eventData.overlays[3] ?? eventData.overlays.first {
//            mapView.setVisibleMapRect (firstOverlay.boundingMapRect,edgePadding: UIEdgeInsets(top: 10, left: 50, bottom: 400, right: 10), animated: false)
//        }
//
//        mapView.mapType = .mutedStandard
//        mapView.pointOfInterestFilter = .excludingAll
//        mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 10000000, maxCenterCoordinateDistance: 10000000)
//        mapView.isRotateEnabled = false
//
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let multiPolygon = overlay as? MKMultiPolygon {
//                let renderer = MKMultiPolygonRenderer(multiPolygon: multiPolygon)
//                renderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.4)
//                renderer.strokeColor = UIColor.systemBlue
//                renderer.lineWidth = 2
//                return renderer
//            }
//            return MKOverlayRenderer(overlay: overlay)
//        }
//
//        @objc func handleZoneTap(_ gestureRecognizer: UITapGestureRecognizer) {
//            let mapView = parent
//            let tapLocation = gestureRecognizer.location(in: mapView)
//            let location = mapView.convert(tapLocation, toCoordinateFrom: mapView)
//            if let zone = parent.mapModel.zoneOfLocation(location) {
//                parent.mapModel.selectedZone = zone
//            }
//        }
//    }
//}


struct ZonesMapView: UIViewRepresentable {
    @EnvironmentObject var mapModel: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = mapModel.mkMapView
        mapView.delegate = context.coordinator
//        mapView.region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 40.8522, longitude: 14.265),
//            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        )
        mapView.mapType = .mutedStandard
        mapView.pointOfInterestFilter = .excludingAll
        //mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 10000000, maxCenterCoordinateDistance: 10000000)
        mapView.isRotateEnabled = false
        
        for zone in mapModel.states {
            let polygon = MKPolygon(coordinates: zone.coordinates, count: zone.coordinates.count)
            mapView.addOverlay(polygon)
        }
//        for zone in mapModel.states {
//            for coordinates in zone.polygons {
//                let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
//                mapView.addOverlay(polygon)
//            }
//        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ZonesMapView
        
        init(_ parent: ZonesMapView) {
            self.parent = parent
            super.init()
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleZoneTap))
            self.parent.mapModel.mkMapView.addGestureRecognizer(gestureRecognizer)
        }
        
        // This function overload specifies the appropiate renderer object for a given map overlay.
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygonOverlay = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygonOverlay)
                renderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        @objc func handleZoneTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let mapView = parent.mapModel.mkMapView
            let tapLocation = gestureRecognizer.location(in: mapView)
            let location = mapView.convert(tapLocation, toCoordinateFrom: mapView)
            if let zone = parent.mapModel.zoneOfLocation(location) {
                parent.mapModel.selectedZone = zone
            }
        }
    }
}




///*
//See the LICENSE.txt file for this sample’s licensing information.
//
//Abstract:
//An example showing how to create a multipolygon from a GeoJSON overlay and render it on the map with a single renderer.
//*/
//
//import Foundation
//import MapKit
//]]
//extension OverlayViewController {
//    func displayMultiPolygonExample() {
//        title = "Multipolygon Renderer"
//
//        let eventData = EventDataSource()
//
//        //mapView.register(EventAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        //mapView.addAnnotations(eventData.annotations)
//
//        mapView.addOverlays(eventData.overlays, level: .aboveRoads)
//
//
//        if let firstOverlay = eventData.overlays.first {
//            mapView.setVisibleMapRect(
//                firstOverlay.boundingMapRect,
//                edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40),
//                animated: false
//            )
//            /// Focus the map on the overlay, adding space around the edges to frame it nicely within the view controller's view.
//            //mapView.setVisibleMapRect(firstOverlay.boundingMapRect, edgePadding: standardPadding, animated: false)
//
//            /**
//             To make sure users don't accidentally pan away from the event and get lost, apply a camera boundary. This ensures that the
//             center point of the map always remains inside this region.
//             */
//            let cameraBoundary = MKCoordinateRegion(center: firstOverlay.coordinate, latitudinalMeters: 100, longitudinalMeters: 80)
//            mapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: cameraBoundary)
//        }
//
//        /// To remove information that interferes with the event map, turn off all points of interest using an `excludingAll` filter.
//        //mapView.pointOfInterestFilter = .excludingAll
//
//        /**
//         There's no reason for users to zoom out to view all of California and beyond, nor does the event map have enough details to make
//         detailed zoom levels relevant. Apply a camera zoom range to restrict how far in and out users can zoom in the map view.
//        */
//        //mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 250, maxCenterCoordinateDistance: 800)
//    }
//
//    /// - Tag: multipolygon_renderer
//    /**
//     An `MKMultiPolygon` represents multiple polygons that all render using the same visual style, lowering the number of
//     required individual rendering objects. If a map is displaying numerous overlays that all need the same style, grouping the
//     polygons into an `MKMultiPolygon` improves performance over rendering each polygon with its own renderer object.
//    */
//    func createMultiPolylineRenderer(for multiPolygon: MKMultiPolygon) -> MKMultiPolygonRenderer {
//        let renderer = MKMultiPolygonRenderer(multiPolygon: multiPolygon)
//        renderer.fillColor = UIColor(named: "MultiPolygonOverlayFill")
//        renderer.strokeColor = UIColor(named: "MultiPolygonOverlayStroke")
//        renderer.lineWidth = 2.0
//
//        return renderer
//    }
//}
