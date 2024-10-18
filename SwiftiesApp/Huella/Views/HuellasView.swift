import SwiftUI

struct HuellasView: View {
    
    @State private var hideBar = false
    
    var body: some View {
        NavigationView {
            VStack{
                topView(title: "Tus Huellas")
                
                // Grilla de huellas
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        HuellaCard(title: "Hídrica", value: 1150, imageName: "grafica_hidrica")
                        HuellaCard(title: "Energética", value: 220, imageName: "grafica_energetica")
                    }
                    HStack(spacing: 20) {
                        HuellaCard(title: "Carbono", value: 1375, imageName: "grafica_carbono")
                        HuellaCard(title: "Residuos", value: 1575, imageName: "grafica_residuos")
                    }
                }.padding(.vertical, 40)
                
                NavigationLink(destination: RecomendacionesAIView()
                ) {
                    Text("Sugerencias de Inteligencia Artificial")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 40)
                }
                
                NavigationLink(destination: Recomendaciones(hideBar: $hideBar).navigationBarTitle("")
                    .navigationBarHidden(hideBar)
                ) {
                    Text("Recomendaciones")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 40)
                }
                
                
                
                Spacer()
            }
        }
    }
}

struct HuellasView_Previews: PreviewProvider {
    static var previews: some View {
        HuellasView()
    }
}
