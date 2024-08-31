import SwiftUI

struct OnBoardView: View {
    @Binding var appState: Int
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()

            VStack (spacing: 16){
                Text("Graph-It 📊")
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.bottom, 10)
    
                
                Button(action: { appState = 1}, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 150, height: 55)
                        .foregroundColor(.white)
                        .overlay(Text("Start")
                            .foregroundColor(.black.opacity(0.9))
                            .font(.title)
                            .fontWeight(.bold)
                )
                    
                })
                
            }
            
            .padding()
        }
    }
}

#Preview {
    OnBoardView(appState: .constant(0))
}

