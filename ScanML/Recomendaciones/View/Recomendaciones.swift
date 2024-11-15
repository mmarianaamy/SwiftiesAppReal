import SwiftUI

struct Recomendaciones: View {
    @State var selectedTab = "Hídrico"
    @State var boton = "Simulador"
    @Binding var hideBar: Bool

    var body: some View {
        VStack{
            
            if(boton == "Simulador"){
                VStack {
                    topView(title: "Recomendaciones")
                    Picker("Recomendaciones", selection: $selectedTab) {
                        Text("Hídrico").tag("Hídrico")
                        Text("Energético").tag("Energético")
                        Text("Carbono").tag("Carbono")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    if selectedTab == "Hídrico" {
                        RecomendacionesView(tipo: "Hídrico")
                    } else if selectedTab == "Energético" {
                        RecomendacionesView(tipo: "Energético")
                    } else if selectedTab == "Carbono" {
                        RecomendacionesView(tipo: "Carbono")
                    } 
                    
                    Spacer()
                    
                }
            }else{
                SimuladorView()
            }
            
            Button{
                if(boton == "Simulador"){
                    boton = "Listo"
                }else{
                    boton = "Simulador"
                }
            } label: {
                Text(boton)
                    .foregroundStyle(Color.white)
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
