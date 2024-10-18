import SwiftUI

struct Recomendaciones: View {
    @State var selectedTab = "Hídrico"
    @Binding var hideBar: Bool
    
    /*
     Errors found! Invalidating cache...
     fopen failed for data file: errno = 2 (No such file or directory)
     Errors found! Invalidating cache...
     */
    
    var body: some View {
        NavigationView {
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
                
                // Botón de tomar hábitos
                NavigationLink(destination: SimuladorView().navigationBarTitle("")
                    //.navigationBarHidden(true)) {
                    ) {
                        Text("Simulador")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 40)
                    }.simultaneousGesture(TapGesture().onEnded {
                        hideBar = false
                     })
                
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Recomendaciones(hideBar: .constant(true))
    }
}
