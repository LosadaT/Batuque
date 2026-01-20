import UIKit
import MapKit


@MainActor
final class MapViewModel: ObservableObject {
    @Published var mkMapView = MKMapView()
    @Published var selectedZone: Zone?
    
    let states: [Zone] = {
        let url = Bundle.main.url(forResource: "br_states-2", withExtension: "json")!
        let decoder = JSONDecoder()
        return try! decoder.decode([Zone].self, from: Data(contentsOf: url))
    }()
    
    let brazil: [Zone] = {
        let url = Bundle.main.url(forResource: "brazil", withExtension: "json")!
        let decoder = JSONDecoder()
        return try! decoder.decode([Zone].self, from: Data(contentsOf: url))
    }()
    
    @MainActor func zoneOfLocation(_ location: CLLocationCoordinate2D) -> Zone? {
        for (index, overlay) in mkMapView.overlays.enumerated() {
            guard let polygon = overlay as? MKPolygon else { continue }
            
            let renderer = MKPolygonRenderer(polygon: polygon)
            let mapPoint = MKMapPoint(location)
            let rendererPoint = renderer.point(for: mapPoint)
            if renderer.path.contains(rendererPoint) && index < states.count{
                return states[index]
            }
        }
        return nil
    }
}

