import SwiftUI

struct HuellasView: View {
    
    @State private var hideBar = false
    
    var body: some View {
        NavigationView {
            
            VStack{
                topView(title: "Tus Huellas")
                
                VStack() {
                    
                    DonutChart()
                    
                }.padding()
                
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
                
            }
            Spacer()
        }
        
    }
}

struct HuellasView_Previews: PreviewProvider {
    static var previews: some View {
        HuellasView()
    }
}
