import SwiftUI

@main
struct GraphItApp: App {
    @Environment(\.colorScheme) var colorScheme

    init() {
      
        UIView.appearance().overrideUserInterfaceStyle = .dark
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

