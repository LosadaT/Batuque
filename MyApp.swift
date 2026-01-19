import SwiftUI

@main
struct MyApp: App {
    @StateObject private var mapModel = MapViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mapModel)
        }
    }
}
