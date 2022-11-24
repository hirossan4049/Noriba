import SwiftUI
import NoribaUI

@main
struct NoribaApp: App {
    @State private var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                SearchView()
                    .navigationDestination(for: VehicleResultNavigation.self) { nav in
                        VehicleResultView(trainNumber: nav.trainNumber,
                                          departureInfo: nav.departureInfo)
                    }
            }
        }
    }
}
