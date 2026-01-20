import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var stateSelected: Zone?
    @State var stateGenre: [String] = []
    
    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationSplitView {
                if mapModel.selectedZone?.id != nil {
                    ForEach(stateGenre, id: \.self) { state in
                        Text(state)
                    }
                }
                
                //            Text("\(mapModel.selectedZone?.id)")
                
                
            } detail: {
                ZStack {
                    BrazilMapView(stateSelected: $stateSelected)
                        .ignoresSafeArea()

                    MapView(stateSelected: $stateSelected)
                        .ignoresSafeArea()
                    //                .onTapGesture {
                    //                    stateSelected = mapModel.selectedZone
                    //                    print("\(mapModel.selectedZone)")
                    //                }
                    //                .navigationDestination(isPresented: Binding(get: {
                    //                    mapModel.selectedZone != nil
                    //                }, set: { isPresented in
                    //                    if !isPresented {
                    //                        mapModel.selectedZone = nil
                    //                    }
                    //                })) {
                    //                    ZoneDetailView()
                    //                }
                }
            }
            .onChange(of: mapModel.selectedZone?.id) {
                if let selectedState = mapModel.selectedZone?.id {
                    stateGenre = getState(state: selectedState)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func getState(state: String) -> [String] {
        switch state {
        case "RJ":
            return ["Samba-Enredo", "Partido-Alto"]
        case "BA":
            return ["Baião", "Olodum", "Axé"]
        case "PE":
            return ["Maracatu", "Frevo", ]
        default:
            return []
        }
    }
}
