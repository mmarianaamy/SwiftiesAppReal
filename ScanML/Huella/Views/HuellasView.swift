import SwiftUI

struct HuellasView: View {
    
    @State private var hideBar = false
    @EnvironmentObject var user : User
    
    var body: some View {
        NavigationView {
            VStack{
                topView(title: "Tus Huellas")
                
                VStack(spacing: 20) {
                    
                    DonutChart()
                    
                }.padding(.vertical, -20)
                
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

#Preview {
    struct PreviewView : View {
        @State var user : User = User(idusuario: 1, nombre: "Juan", apellido: "Perez", email: "juan.perez@example.com", contraseña: "password123")
        var body : some View {
            HuellasView()
        }
    }
    
    return PreviewView()
}
