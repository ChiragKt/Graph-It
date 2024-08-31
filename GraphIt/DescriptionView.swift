import SwiftUI

struct DescriptionView: View {
    @Binding var appState: Int
    @Binding var selectedAlgorithm: String
    @Binding var currentDescription: String
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {appState = 2
                        
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                    }).padding(.leading)
                    Spacer()
                    Text("\(selectedAlgorithm)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                Spacer()
                Text("\(currentDescription)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .lineSpacing(5.0)
                Spacer()
            }
        }
    }
    
}

#Preview {
    DescriptionView(appState: .constant(2), selectedAlgorithm: .constant("Bubble-Sort"), currentDescription: .constant("Bubble Sort is one of the simplest sorting algorithms, often used for educational purposes to illustrate the concept of sorting. The algorithm repeatedly steps through the list of items to be sorted, compares each pair of adjacent items, and swaps them if they are in the wrong order. This process is repeated until the entire list is sorted. The largest unsorted elements 'bubble up' to their correct position with each pass through the list. While easy to understand and implement, Bubble Sort is inefficient for large datasets due to its O(n²) time complexity in the average and worst cases. It’s best used for small or nearly sorted arrays."))
}
