import SwiftUI

struct Recomendaciones: View {
    @State var selectedTab = "Hídrico"
    @State var boton = "Simulador"
    @Binding var hideBar: Bool
    @State var emissionVM = EmissionViewModel()
    @State var isTaskCompleted: Bool = false // Track task completion

    var body: some View {
        VStack {
            if boton == "Simulador" {
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
                        RecomendacionesView(tipo: "Hídrico", emissionVM: $emissionVM, isTaskCompleted: $isTaskCompleted)
                    } else if selectedTab == "Energético" {
                        RecomendacionesView(tipo: "Energético", emissionVM: $emissionVM, isTaskCompleted: $isTaskCompleted)
                    } else if selectedTab == "Carbono" {
                        RecomendacionesView(tipo: "Carbono", emissionVM: $emissionVM, isTaskCompleted: $isTaskCompleted)
                    }
                    
                    Spacer()
                }
            } else {
                SimuladorView(emissionVM: $emissionVM)
            }
            
            Button {
                if boton == "Simulador" {
                    boton = "Listo"
                } else {
                    boton = "Simulador"
                }
            } label: {
                Text(boton)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(isTaskCompleted ? Color.blue : Color.gray) // Change button color based on task status
                    .cornerRadius(10)
                    .padding(.top, 40)
            }
            .disabled(!isTaskCompleted) // Disable button if task is not completed
        }
    }
}
