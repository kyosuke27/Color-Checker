import SwiftUI


struct ContentView: View {
    @State var r:String = "0"
    @State var g:String = "0"
    @State var b:String = "0"
    @State var color:Color = .white
    let maxValue = 255
    let minLimtValue = 0
    
    private func rounded2(value:Double)->Double{
        return (value*100).rounded()/100
    }
    
    private func RGBtoColor() -> Color{
        let calcR = Double(min(max((Int(r) ?? 0), minLimtValue),maxValue))/255.0
        let calcG = Double(min(max((Int(g) ?? 0), minLimtValue),maxValue))/255.0
        let calcB = Double(min(max((Int(b) ?? 0), minLimtValue),maxValue))/255.0
        return Color(red: rounded2(value:calcR), green: rounded2(value: calcG), blue: rounded2(value: calcB))
    }
    var body: some View {
        VStack {
            HStack{
                TextField(text: $r, prompt: Text("255")) {
                    Text("R")
                }
                .keyboardType(.numberPad)
                .padding()
                .border(Color.purple, width: 1)
                TextField(text: $g, prompt: Text("255")) {
                    Text("G")
                }
                .keyboardType(.numberPad)
                .padding()
                .border(Color.purple, width: 1)
                TextField(text: $b, prompt: Text("255")) {
                    Text("B")
                }
                .keyboardType(.numberPad)
                .padding()
                .border(Color.purple, width: 1)
                
            }
            RoundedRectangle(cornerRadius: 30)
                .fill(color)
                .frame(maxWidth:.infinity)
                .frame(height: 200)
            Spacer()
            Button {
                color = RGBtoColor()
            } label: {
                Text("カラー選択")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue.opacity(0.5))
            }
            Spacer()
            Button {
                color = .white
            } label: {
                Text("リセット")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.purple.opacity(0.5))
            }
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
