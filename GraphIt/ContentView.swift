import SwiftUI

struct ContentView: View {
    @State private var appState: Int = 0
    @State private var selectedAlgorithm: String = ""
    @State private var numArray: [Int] = []
    @State private var currentDescription: String = ""
    
    var body: some View {
        ZStack {
            switch appState {
            case 0:
                OnBoardView(appState: $appState)
            case 1:
                MainView(numArray: $numArray, selectedAlgorithm: $selectedAlgorithm, appState: $appState)
            case 2:
                SortView(numArray: $numArray, selectedAlgorithm: $selectedAlgorithm, appState: $appState, currentDescription: $currentDescription)
            case 3:
                DescriptionView(appState: $appState, selectedAlgorithm: $selectedAlgorithm, currentDescription: $currentDescription)
            default:
                OnBoardView(appState: $appState)
            }
        }
    }
}

#Preview {
    ContentView()
}
