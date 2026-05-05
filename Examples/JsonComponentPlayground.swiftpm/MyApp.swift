import SwiftUI

@main
struct MyApp: App {
    init() {
        Components.setUp()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
