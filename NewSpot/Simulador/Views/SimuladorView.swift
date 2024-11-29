//
//  SiteView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 30/10/24.
//

import SwiftUI

struct SimuladorView: View {
    @State var selection = 0
    @State var currentTab: String = "7 Days"
    @Binding var emissionVM: EmissionViewModel

    var body: some View {
        VStack {
            topView(title: "Simulador")
            
            HStack {
                HStack {
                    Circle().frame(width: 10, height: 10)
                        .foregroundStyle(Color.background)
                        
                    Text("Actual")
                }
                .padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6).stroke(.button, lineWidth: 0.4)
                        .stroke(Color.gray)
                        .opacity(0.2)
                )
                
                HStack {
                    Circle().frame(width: 10, height: 10)
                        .foregroundStyle(Color.red.opacity(1.0))
                        
                    Text("Cambio")
                }
                .padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6).stroke(.button, lineWidth: 0.4)
                        .stroke(Color.gray)
                        .opacity(0.2)
                )
                
                Picker("", selection: $currentTab) {
                    Text("Día").tag("7 Days")
                    Text("Mes").tag("Month")
                    Text("Año").tag("Year")
                }
                .pickerStyle(.segmented)
                .padding(.leading, 20)
            }.padding(.horizontal)
                
            
            ScrollView {
                VStack {
                    GraphRealView(currentTab: $currentTab, realVM: $emissionVM)
                    GraphSimulationView(currentTab: $currentTab, fakeVM: $emissionVM)
                        .padding(.top, -20)
                    /*VStack(alignment: .leading) {
                        Text("¿Sabías que?")
                            .font(.headline)
                        
                        Text("Si cambias tus hábitos puedes reducir tu impacto ecológico por un 50%")
                            .font(.body)
                            .padding(.bottom, 20)
                    }
                    .padding()*/
                }
            }
            
            
            
            Spacer()
        }
    }
}

/*struct SimuladorView_Previews: PreviewProvider {
    static var previews: some View {
        SimuladorView()
    }
}
*/
