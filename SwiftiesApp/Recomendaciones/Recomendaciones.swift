import SwiftUI

struct Recomendaciones: View {
    @State var selectedTab = "Hídrico"
    @State var boton = "Simulador"
    @Binding var hideBar: Bool
    
    /*
     Errors found! Invalidating cache...
     fopen failed for data file: errno = 2 (No such file or directory)
     Errors found! Invalidating cache...
     */
    
    var body: some View {
        VStack{
            
            if(boton == "Simulador"){
                VStack {
                    topView(title: "Recomendaciones")
                    // Picker para seleccionar la tab en la parte superior
                    Picker("Recomendaciones", selection: $selectedTab) {
                        Text("Hídrico").tag("Hídrico")
                        Text("Energético").tag("Energético")
                        Text("Carbono").tag("Carbono")
                        Text("Residuos").tag("Residuos")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Mostrar la vista correspondiente a la tab seleccionada
                    if selectedTab == "Hídrico" {
                        RecomendacionesView(tipo: "Hídrico")
                    } else if selectedTab == "Energético" {
                        RecomendacionesView(tipo: "Energético")
                    } else if selectedTab == "Carbono" {
                        RecomendacionesView(tipo: "Carbono")
                    } else if selectedTab == "Residuos" {
                        RecomendacionesView(tipo: "Residuos")
                    }
                    
                    Spacer()
                    
                }
            }else{
                SimuladorView()
            }
            
            Button{
                if(boton == "Simulador"){
                    boton = "Recomendaciones"
                }else{
                    boton = "Simulador"
                }
            } label: {
                Text(boton)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 40)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Recomendaciones(hideBar: .constant(true))
    }
}
