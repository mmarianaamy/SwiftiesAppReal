import SwiftUI

struct SimuladorView: View {
    @State private var selectedTime = "12 meses" // Estado para el botón seleccionado
    @State var selection = 0
    
    var body: some View {
        VStack {
            
            topView(title: "Simulador")
            
            
            HStack {
                HStack {
                    Circle().frame(width: 10, height: 10)
                        .foregroundStyle(Color.purple)
                        
                    Text("Actual")
                }.padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6).stroke(.button, lineWidth: 0.4)
                        .stroke(Color.gray)
                        .opacity(0.2)
                )
                HStack {
                    Circle().frame(width: 10, height: 10)
                        .foregroundStyle(Color.red.opacity(0.8))
                        
                    Text("Cambio")
                }.padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6).stroke(.button, lineWidth: 0.4)
                        .stroke(Color.gray)
                        .opacity(0.2)
                )
                
                Picker("Habitos o diario", selection: $selection) {
                    Text("7 días").tag(0)
                    Text("30 días").tag(1)
                    Text("12 meses").tag(1)
                }
                .pickerStyle(.segmented).padding()
            }.padding(.horizontal)
            
            // Gráfico (Imagen)
            GraphView(imageName: "graph_image") // Aquí debes poner el nombre de tu imagen
                .frame(height: 200)
                .padding(.horizontal, 20)
            
            // Texto informativo
            VStack (alignment: .leading){
                Text("¿Sabías que?")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                Text("Si cambias tus hábitos puedes reducir tu impacto ecológico por un 50%")
                    .font(.body)
                    .padding(.bottom, 20)
            }.padding()
            
            
            
            Spacer()
    
        }
    }
}

struct SimuladorView_Previews: PreviewProvider {
    static var previews: some View {
        SimuladorView()
    }
}
