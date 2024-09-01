import SwiftUI
import Charts

struct SortView: View {
    @Binding var numArray: [Int]
    @Binding var selectedAlgorithm: String
    @Binding var appState: Int
    @Binding var currentDescription: String
    @State var chartArray: [String] = ["Bar Graph", "Line Graph"]
    @State var timeSheetStatus: Bool = false
    @State var descriptionSheetStatus: Bool = false
    @State private var sortedArray: [Int] = []
    @State private var currentIndex = 0
    @State private var startGraph: Bool = false
    @State private var chartType: String = "Bar Graph"
    @State var currentBestTimeComplexity: String = ""
    @State var currentAvgTimeComplexity: String = ""
    @State var currentWorstTimeComplexity: String = ""
    
    let timer = Timer.publish(every: 0.85, on: .main, in: .common).autoconnect()
    
    
    var bubbleSort = TimeComplexityChart(best: "O(n)", avg: "O(n²)", worst: "O(n²)", description: "Bubble Sort is one of the simplest sorting algorithms, often used for educational purposes to illustrate the concept of sorting. The algorithm repeatedly steps through the list of items to be sorted, compares each pair of adjacent items, and swaps them if they are in the wrong order. This process is repeated until the entire list is sorted. The largest unsorted elements 'bubble up' to their correct position with each pass through the list. While easy to understand and implement, Bubble Sort is inefficient for large datasets due to its O(n²) time complexity in the average and worst cases. It’s best used for small or nearly sorted arrays.")
      
    
     let selectionSort = TimeComplexityChart(best: "O(n²)", avg: "O(n²)", worst: "O(n²)", description: "Selection Sort is an in-place comparison-based algorithm that divides the list into a sorted and an unsorted region. Initially, the sorted region is empty, and the unsorted region contains all elements. The algorithm repeatedly selects the smallest (or largest) element from the unsorted region and moves it to the end of the sorted region. This selection process continues until all elements are sorted. Although simple and intuitive, Selection Sort has a time complexity of O(n²) in all cases, making it inefficient for large datasets. It performs well with smaller datasets or when memory usage is a concern, as it sorts the list in place without needing additional storage.")
    let insertionSort = TimeComplexityChart(best: "O(n)", avg: "O(n²)", worst: "O(n²)", description: "Insertion Sort builds the final sorted array one item at a time by repeatedly taking an unsorted element and inserting it into its correct position in the already sorted portion of the array. It begins with an empty sorted section and iterates through the array, comparing each new element to the sorted section and shifting elements as needed to make room for the new element. This algorithm is efficient for small datasets or nearly sorted arrays due to its O(n) time complexity in the best case, but it can be slow with larger arrays due to its O(n²) average and worst-case time complexities.")
    let mergeSort = TimeComplexityChart(best: "O(n log n)", avg: "O(n log n)", worst: "O(n log n)", description: "Merge Sort is a sophisticated divide-and-conquer algorithm that divides the array into two halves, recursively sorts each half, and then merges the sorted halves to produce a single sorted array. The merging step involves combining two sorted arrays into one sorted array. Merge Sort is known for its consistent O(n log n) time complexity, making it highly efficient for large datasets. It is a stable sort, meaning that it maintains the relative order of equal elements. However, it requires additional space proportional to the size of the array, which can be a drawback in memory-constrained environments.")
    
    let quickSort = TimeComplexityChart(best: "O(n log n)", avg: "O(n log n)", worst: "O(n²)", description: "Quick Sort is a divide-and-conquer algorithm that works by selecting a 'pivot' element from the array and partitioning the other elements into two sub-arrays, according to whether they are less than or greater than the pivot. The pivot is then placed in its correct position, and the sub-arrays are recursively sorted. Quick Sort is known for its average-case time complexity of O(n log n), making it faster than many other sorting algorithms. However, its worst-case time complexity is O(n²), which occurs when the pivot choices are poor (e.g., always choosing the smallest or largest element). In practice, Quick Sort often performs well due to its efficient use of memory and cache.")
    
    let heapSort = TimeComplexityChart(best: "O(n log n)", avg: "O(n log n)", worst: "O(n log n)", description: "Heap Sort is a comparison-based algorithm that converts the array into a heap data structure, which is a binary tree with specific properties. It then repeatedly extracts the maximum (or minimum) element from the heap and reconstructs the heap until the entire array is sorted. The heap construction and extraction processes are both O(log n), and the overall time complexity of Heap Sort is O(n log n). Heap Sort is efficient and performs well for large datasets. Unlike Quick Sort, it does not require additional memory for recursion, as it sorts in place. However, it is not a stable sort, meaning that it does not preserve the relative order of equal elements.")
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack {
                HStack{
                    Button(action: {
                        appState = 1
                        numArray = []
                        sortedArray = []
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                    }).padding(.leading)
                    Spacer()
                    Text("\(selectedAlgorithm)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(Color(red: 252/255, green: 245/255, blue: 237/255))
                    .frame(width: 350, height: 400)
                    .overlay(
                        withAnimation(.bouncy) {
                            Chart {
                                ForEach(0..<sortedArray.count, id: \.self) { index in
                                    if(chartType == "Line Graph") {
                                        LineMark(
                                            x: .value("Index", Double(index)),
                                            y: .value("Value", sortedArray[index])
                                        )
                                        .foregroundStyle(Color.brown.gradient.opacity(0.4))
                                    } else {
                                        BarMark(
                                            x: .value("Index", Double(index)),
                                            y: .value("Value", sortedArray[index])
                                        )
                                        .foregroundStyle(Color.pink.gradient)
                                    }
                                }
                            }
                            .chartXAxis(.hidden)
                            .chartXScale(domain: -0.5...Double(sortedArray.count) - 0.5)
                            .padding(.horizontal, 10)
                            .frame(width: 300, height: 300)
                        }
                    )
                Spacer()
                
                Picker(selection: $chartType, content: {
                    ForEach(chartArray, id: \.self) { index in
                        Text("\(index)").foregroundColor(.pink)
                    }
                }, label: {
                    Text("Select graph style...")
                })
                .pickerStyle(.wheel)
                .onChange(of: chartType) { _ in
                    withAnimation(.bouncy) {
                        resetChart()
                        currentIndex = 0
                        startGraph = false
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.bouncy) {
                            startGraph = true
                        }
                    }
                }


                
                HStack {
                    Button(action: {
                        appState = 3
                    }, label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .shadow(color: .white, radius: 8)
                            .frame(width: 250, height: 55)
                            .foregroundColor(.white)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Image(systemName: "lines.measurement.vertical")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                        .padding(0)
                                        .foregroundColor(.black)
                                    Text("Description")
                                        .font(.headline)
                                        .padding()
                                        .foregroundColor(.black)
                                        .cornerRadius(5)
                                    Spacer()
                                }
                            )
                    }).padding(.bottom, 30)
                }
                HStack {
                    Button(action: {
                        timeSheetStatus = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .shadow(color: .white, radius: 8)
                            .frame(width: 250, height: 55)
                            .foregroundColor(.white)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Image(systemName: "clock.badge.checkmark")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                        .padding(0)
                                        .foregroundColor(.black)
                                    Text("Time Complexity")
                                        .font(.headline)
                                        .padding()
                                        .foregroundColor(.black)
                                        .cornerRadius(5)
                                    Spacer()
                                }
                            )
                    })
                }
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $timeSheetStatus, content: {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("\(selectedAlgorithm)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack {
                        Text("Best Time Complexity:    ")
                            .foregroundColor(.pink)
                        Text("\(currentBestTimeComplexity)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    HStack {
                        Text("Average Time Complexity:    ")
                            .foregroundColor(.pink)
                        Text("\(currentAvgTimeComplexity)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    HStack {
                        Text("Worst Time Complexity:    ")
                            .foregroundColor(.pink)
                        Text("\(currentWorstTimeComplexity)")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        })
        .onAppear {
            sortedArray = numArray
        }
        .onReceive(timer) { _ in
            switch selectedAlgorithm {
            case "Bubble-Sort":
                currentBestTimeComplexity = bubbleSort.best
                currentAvgTimeComplexity = bubbleSort.avg
                currentWorstTimeComplexity = bubbleSort.worst
                currentDescription = bubbleSort.description
                bubbleSortStep()
                
            case "Selection-Sort":
                currentBestTimeComplexity = selectionSort.best
                currentAvgTimeComplexity = selectionSort.avg
                currentWorstTimeComplexity = selectionSort.worst
                currentDescription = selectionSort.description
                selectionSortStep()
                
            case "Insertion-Sort":
                currentBestTimeComplexity = insertionSort.best
                currentAvgTimeComplexity = insertionSort.avg
                currentWorstTimeComplexity = insertionSort.worst
                currentDescription = insertionSort.description
                insertionSortStep()
                
            case "Merge-Sort":
                currentBestTimeComplexity = mergeSort.best
                currentAvgTimeComplexity = mergeSort.avg
                currentWorstTimeComplexity = mergeSort.worst
                currentDescription = mergeSort.description
                mergeSortStep()
                
            case "Quick-Sort":
                currentBestTimeComplexity = quickSort.best
                currentAvgTimeComplexity = quickSort.avg
                currentWorstTimeComplexity = quickSort.worst
                currentDescription = quickSort.description
                quickSortStep()
                
            case "Heap-Sort":
                currentBestTimeComplexity = heapSort.best
                currentAvgTimeComplexity = heapSort.avg
                currentWorstTimeComplexity = heapSort.worst
                currentDescription = heapSort.description
                heapSortStep()
                
            default:
                break
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    
    
    private func resetChart() {
        sortedArray = []
        currentIndex = 0
        sortedArray = numArray
    }
    
   
    private func bubbleSortStep() {
        guard sortedArray.count > 1 else { return }
        var swapped = false
        for j in 0..<(sortedArray.count - 1 - currentIndex) {
            if sortedArray[j] > sortedArray[j + 1] {
                sortedArray.swapAt(j, j + 1)
                swapped = true
            }
        }
        currentIndex += 1
        if !swapped {
            timer.upstream.connect().cancel()
        }
    }
    
    private func selectionSortStep() {
        guard sortedArray.count > 1 else { return }
        var minIndex = currentIndex
        for j in (currentIndex + 1)..<sortedArray.count {
            if sortedArray[j] < sortedArray[minIndex] {
                minIndex = j
            }
        }
        if minIndex != currentIndex {
            sortedArray.swapAt(currentIndex, minIndex)
        }
        currentIndex += 1
        if currentIndex >= sortedArray.count {
            timer.upstream.connect().cancel()
        }
    }
    
    private func insertionSortStep() {
        guard sortedArray.count > 1 else { return }
        let key = sortedArray[currentIndex]
        var j = currentIndex - 1
        while j >= 0 && sortedArray[j] > key {
            sortedArray[j + 1] = sortedArray[j]
            j -= 1
        }
        sortedArray[j + 1] = key
        currentIndex += 1
        if currentIndex >= sortedArray.count {
            timer.upstream.connect().cancel()
        }
    }
    
    private func mergeSortStep() {
        guard sortedArray.count > 1 else { return }
        sortedArray = mergeSortHelper(sortedArray)
        timer.upstream.connect().cancel()
    }
    
    private func mergeSortHelper(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        
        let middleIndex = array.count / 2
        let leftArray = mergeSortHelper(Array(array[0..<middleIndex]))
        let rightArray = mergeSortHelper(Array(array[middleIndex..<array.count]))
        
        return merge(leftArray, rightArray)
    }
    
    private func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        var mergedArray: [Int] = []
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                mergedArray.append(left[leftIndex])
                leftIndex += 1
            } else {
                mergedArray.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            mergedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            mergedArray.append(right[rightIndex])
            rightIndex += 1
        }
        
        return mergedArray
    }
    
    private func quickSortStep() {
        guard sortedArray.count > 1 else { return }
        sortedArray = quickSortHelper(sortedArray)
        timer.upstream.connect().cancel()
    }
    
    private func quickSortHelper(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        
        let pivot = array[array.count / 2]
        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }
        
        return quickSortHelper(less) + equal + quickSortHelper(greater)
    }
    
    private func heapSortStep() {
        guard sortedArray.count > 1 else { return }
        sortedArray = heapSortHelper(sortedArray)
        timer.upstream.connect().cancel()
    }
    
    private func heapSortHelper(_ array: [Int]) -> [Int] {
        var heap = array
        
        
        for i in stride(from: (heap.count / 2) - 1, through: 0, by: -1) {
            heapify(&heap, heap.count, i)
        }
        
      
        for i in stride(from: heap.count - 1, through: 1, by: -1) {
            heap.swapAt(0, i)
            heapify(&heap, i, 0)
        }
        
        return heap
    }
    
    private func heapify(_ heap: inout [Int], _ size: Int, _ rootIndex: Int) {
        var largest = rootIndex
        let leftChild = 2 * rootIndex + 1
        let rightChild = 2 * rootIndex + 2
        
        if leftChild < size && heap[leftChild] > heap[largest] {
            largest = leftChild
        }
        
        if rightChild < size && heap[rightChild] > heap[largest] {
            largest = rightChild
        }
        
        if largest != rootIndex {
            heap.swapAt(rootIndex, largest)
            heapify(&heap, size, largest)
        }
    }
}

struct TimeComplexityChart {
    let best: String
    let avg: String
    let worst: String
    let description: String
}
