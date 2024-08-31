import SwiftUI

struct MainView: View {
    @State private var num: Int = 1
    @State private var arraySize: Int = 5
    @Binding var numArray: [Int]
    @State private var addNum: String = ""
    @State private var sheetState: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    let algorithm = [
        1: "Bubble-Sort",
        2: "Selection-Sort",
        3: "Insertion-Sort",
        4: "Merge-Sort",
        5: "Quick-Sort",
        6: "Heap-Sort",
    ]

    @Binding var selectedAlgorithm: String
    @Binding var appState: Int

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("Graph-It 📊")
                        .foregroundColor(.pink)
                        .font(.system(size: 65))
                        .fontWeight(.bold)
                }
                .padding()

                Text("Data-Set size 💾")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                Picker(selection: $arraySize, content: {
                    ForEach(1..<21) { index in
                        Text("\(index)")
                            .foregroundColor(.pink)
                    }
                }, label: {
                    Text("Select array size.. ")
                })
                .pickerStyle(.wheel)

                Spacer()

                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.pink)
                    .overlay(
                        ZStack(alignment: .leading) {
                            if addNum.isEmpty {
                                if num <= arraySize {
                                    Text("   Enter Number \(num)...")
                                        .foregroundColor(.black)
                                        .padding(.leading, 8)
                                        .padding(.vertical, 14)
                                } else {
                                    Text(" Select sorting algorithm 🧩")
                                        .foregroundColor(.black)
                                        .padding(.leading, 8)
                                        .padding(.vertical, 14)
                                }
                            }
                            TextField("", text: $addNum)
                                .keyboardType(.numberPad)
                                .foregroundColor(.black)
                                .padding()
                        }
                    )
                    .frame(width: 350, height: 55)
                    .cornerRadius(5)

                Spacer()

                Button(action: {
                    if numArray.count >= arraySize {
                        showAlert = true
                        alertMessage = "Size Limit Exceeded: Cannot add more numbers."
                        return
                    }

                    if let number = Int(addNum) {
                        numArray.append(number)
                        addNum = ""
                        num += 1
                    } else {
                        showAlert = true
                        alertMessage = "Invalid Input: Please enter a valid number."
                    }
                }) {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 250, height: 55)
                        .foregroundColor(Color(red: 31/255, green: 23/255, blue: 23/255))
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "number.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                Text("Add Number ")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        )
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
                }

                Button(action: {
                    if numArray.isEmpty {
                        showAlert = true
                        alertMessage = "Cannot visualize empty data-set."
                    } else {
                        sheetState = true
                    }
                }) {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 250, height: 55)
                        .foregroundColor(Color(red: 31/255, green: 23/255, blue: 23/255))
                        .overlay(
                            HStack {
                                Image(systemName: "arrow.left.and.right.text.vertical")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                Text("Select Sort")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                .cornerRadius(5)
                            }
                        )
                }
            }
            .padding()

            .sheet(isPresented: $sheetState) {
                ZStack {
                    Color.pink.ignoresSafeArea()
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[1] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "b.square")
                                                .foregroundColor(.white)
                                            Text("Bubble")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[2] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "s.square")
                                                .foregroundColor(.white)
                                            Text("Selection")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                        }
                        .padding()

                        HStack {
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[3] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "i.square")
                                                .foregroundColor(.white)
                                            Text("Insertion")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[4] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "m.square")
                                                .foregroundColor(.white)
                                            Text("Merge")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                        }
                        .padding()

                        HStack {
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[5] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "q.square")
                                                .foregroundColor(.white)
                                            Text("Quick")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                            Button(action: {
                                selectedAlgorithm = algorithm[6] ?? ""
                                appState = 2
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .shadow(color: .black, radius: 5)
                                    .foregroundColor(.black)
                                    .frame(width: 170, height: 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "h.square")
                                                .foregroundColor(.white)
                                            Text("Heap")
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    )
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

#Preview {
    MainView(numArray: .constant([]), selectedAlgorithm: .constant("Bubble Sort"), appState: .constant(0))
}

