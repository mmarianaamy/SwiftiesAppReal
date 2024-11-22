import SwiftUI

struct HuellasView: View {
    
    @State private var hideBar = false
    @State private var categorias = "Mensual"
    @EnvironmentObject var user : User
    
    var body: some View {
        NavigationView {
            VStack{
                topView(title: "Tus Huellas")
                
                ScrollView() {
                    VStack(spacing: 20) {
                        
                        DonutChart().padding(.top, 5)
                        
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
                            .padding(.top, 15)
                    }
                    
                    ///Specific Graphs
                    VStack (alignment: .leading){
                        Text("Graficas por huella")
                            .font(.title2)
                            .bold()
                        
                        VStack (alignment: .leading){
                            Divider()
                                .frame(minHeight: 1)
                                .overlay(.yellow)
                            Text("Huella energética")
                                .font(.headline)
                            HuellaEnergeticaMes()
                        }
                        
                        VStack (alignment: .leading){
                            Divider()
                                .frame(minHeight: 1)
                                .overlay(Color.blue)
                            Text("Huella hídrica")
                                .font(.headline)
                            HuellaHidricaMes()
                        }
                        
                        VStack (alignment: .leading){
                            Divider()
                                .frame(minHeight: 1)
                                .overlay(Color.green)
                            Text("Huella de carbono")
                                .font(.headline)
                            HuellaCO2Mes()
                        }
                        /*
                        Picker("", selection: $categorias) {
                            Text("Mensual").tag("Mensual")
                            Text("Categoría").tag("Categoría")
                        }.pickerStyle(.segmented)
                        if categorias == "Mensual"{
                            VStack (alignment: .leading){
                                Divider()
                                    .frame(minHeight: 1)
                                    .overlay(.yellow)
                                Text("Huella energética")
                                    .font(.headline)
                                HuellaEnergeticaMes()
                            }
                            
                            VStack (alignment: .leading){
                                Divider()
                                    .frame(minHeight: 1)
                                    .overlay(Color.blue)
                                Text("Huella hídrica")
                                    .font(.headline)
                                HuellaHidricaMes()
                            }
                            
                            VStack (alignment: .leading){
                                Divider()
                                    .frame(minHeight: 1)
                                    .overlay(Color.green)
                                Text("Huella de carbono")
                                    .font(.headline)
                                HuellaCO2Mes()
                            }
                        }*/
                        
                    }.padding()
                    
                    
                }.padding(.top, -8)
                
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    HuellasView().environmentObject(User(idusuario: 16))
}
