import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var stateGenre: [String] = []
    @State var selectedGenre: String?
    @State var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var selection: String?

    var genreVM = GenreViewModel()
    
    var body: some View {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                if mapModel.selectedZone?.id != nil {
                    List(stateGenre, id: \.self) { genre in
                        if selectedGenre == genre {
                            Label(genre, systemImage: "heart.fill")
                                .labelColor()
                                .tag(genre)
                                .onTapGesture {
                                    selectedGenre = genre
                                }
                                .padding(8)
                                .padding(.horizontal)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        else {
                            Label(genre, systemImage: "heart.fill")
                                .labelColor()
                                .tag(genre)
                                .onTapGesture {
                                    selectedGenre = genre
                                }
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
                else {
                    Text("Click on an highlight state to learn more about his music!")

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
                    columnVisibility = NavigationSplitViewVisibility.all
                }
            }
    }
}
