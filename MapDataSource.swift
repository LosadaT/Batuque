import UIKit
import MapKit


@MainActor
final class MapViewModel: ObservableObject {
    @Published var mkMapView = MKMapView()
    @Published var selectedZone: Zone?
    
    let states: [Zone] = {
        let url = Bundle.main.url(forResource: "br_states 1", withExtension: "json")!
        let decoder = JSONDecoder()
        return try! decoder.decode([Zone].self, from: Data(contentsOf: url))
    }()
    
    @MainActor func zoneOfLocation(_ location: CLLocationCoordinate2D) -> Zone? {
        for (index, overlay) in mkMapView.overlays.enumerated() {
            guard let polygon = overlay as? MKPolygon else { continue }
            
            let renderer = MKPolygonRenderer(polygon: polygon)
            let mapPoint = MKMapPoint(location)
            let rendererPoint = renderer.point(for: mapPoint)
            if renderer.path.contains(rendererPoint) {
                return states[index]
            }
        }
        return nil
    }
    //    let states: [Zone] = {
    //        let url = Bundle.main.url(forResource: "br_states 1", withExtension: "json")!
    //        let decoder = JSONDecoder()
    //        return try! decoder.decode([Zone].self, from: Data(contentsOf: url))
    
    //        guard let url = Bundle.main.url(forResource: "brazil_geo-3", withExtension: "json") else {
    //            return []
    //        }
    //
    //        let decoder = JSONDecoder()
    //        guard let geoJSON = try? decoder.decode(GeoJSON.self, from: Data(contentsOf: url))
    //        else {
    //            print("nao foi")
    //            return []
    //        }
    //
    //        return geoJSON.features.map { feature in
    //            let polygons = feature.geometry.coordinates.map { polygon in
    //                let outerRing = polygon.first ?? []
    //
    //                return outerRing.map { point in
    //                    CLLocationCoordinate2D(
    //                        latitude: point[1],
    //                        longitude: point[0]
    //                    )
    //                }
    //            }
    //            return Zone(
    //                id: feature.properties.id,
    //                polygons: polygons
    //            )
    //        }
    //    }()
    
    //    func addZonesToMap() {
    //        for zone in states {
    //            let mkPolygons = zone.polygons.map {
    //                MKPolygon(coordinates: $0, count: $0.count)
    //            }
    //
    //            let multiPolygon = MKMultiPolygon(mkPolygons)
    //            mkMapView.addOverlay(multiPolygon)
    //        }
    //    }
    
    //    func zoneOfLocation(_ location: CLLocationCoordinate2D) -> Zone? {
    //        let mapPoint = MKMapPoint(location)
    //
    //        for (index, overlay) in mkMapView.overlays.enumerated() {
    //            guard let multi = overlay as? MKMultiPolygon else { continue }
    //
    //            let renderer = MKMultiPolygonRenderer(multiPolygon: multi)
    //            let rendererPoint = renderer.point(for: mapPoint)
    //
    //            if renderer.path.contains(rendererPoint) {
    //                return states[index]
    //            }
    //        }
    //        return nil
    //    }
}
//class MapDataSource {
//    private(set) var overlays = [MKOverlay]()
//
//    /// - Tag: geojson_parse
//    init() {
//        if let jsonUrl = Bundle.main.url(forResource: "br_states", withExtension: "json") {
//            do {
//                let eventData = try Data(contentsOf: jsonUrl)
//                let decoder = MKGeoJSONDecoder()
//                let jsonObjects = try decoder.decode(eventData)
//                parse(jsonObjects)
//            } catch {
//            }
//        } else {
//        }
//    }
//
//    private func parse(_ jsonObjects: [MKGeoJSONObject]) {
//        for object in jsonObjects {
//            if let feature = object as? MKGeoJSONFeature {
//                for geometry in feature.geometry {
//                    if let multiPolygon = geometry as? MKMultiPolygon {
//                        overlays.append(multiPolygon)
//                    }
//                }
//            }
//        }
//    }
//
//    private func configure(annotation: MKPointAnnotation, using properties: Data?) {
//        guard let properties = properties else {
//            return
//        }
//        let decoder = JSONDecoder()
//    }
//}
