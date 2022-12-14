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
                        VehicleResultView(viewModel: VehicleResultViewModel(trainNumber: nav.trainNumber,
                                                                            bound: nav.bound,
                                                                            station: nav.station))
                    }
            }
        }
    }
}
