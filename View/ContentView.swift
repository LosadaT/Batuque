import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var stateGenre: [String] = []
    @State var selectedGenre: String?
    
    var genreVM = GenreViewModel()
    
    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationSplitView {
                if mapModel.selectedZone?.id != nil {
                    List(stateGenre, id: \.self) { genre in
                        Label(genre, systemImage: "heart.fill")
                            .tag(genre)
                            .onTapGesture {
                                selectedGenre = genre
                            }
                    }
                }
                else {
                    Text("Click on an highlight state to learn more about his music!")
                        .multilineTextAlignment(.center)
                }
                
            } content: {
                if selectedGenre != nil {
                    genreVM.getGenreInfo(genre: selectedGenre!)
                }
            } detail: {
                ZStack {
                    MapView()
                        .ignoresSafeArea()
                    BrazilMapView()
                        .ignoresSafeArea()
                }
            }
            .onChange(of: mapModel.selectedZone?.id) {
                if let selectedState = mapModel.selectedZone?.id {
                    stateGenre = genreVM.getStateGenre(state: selectedState)
                }
            }
        } else { }
    }
}
