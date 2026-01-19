import SwiftUI
import MapKit

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
