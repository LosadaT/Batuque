import SwiftUI

@available(iOS 17.0, *)
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
