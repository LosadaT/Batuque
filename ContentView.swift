import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    var body: some View {
        NavigationStack {
            ZonesMapView()
                .ignoresSafeArea()
                .navigationDestination(isPresented: Binding(get: {
                    mapModel.selectedZone != nil
                }, set: { isPresented in
                    if !isPresented {
                        mapModel.selectedZone = nil
                    }
                })) {
                    ZoneDetailView()
                }
        }
    }
}
