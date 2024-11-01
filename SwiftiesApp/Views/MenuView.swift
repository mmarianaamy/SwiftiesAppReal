//
//  MenuView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI
import Intents

struct MenuView: View {
    var body: some View {
        TabView{
            DatosView().tabItem{
                Label("Datos", systemImage: "chart.bar.fill")
            }
            HuellasView().tabItem{
                Label("Huellas", systemImage: "chart.pie.fill")
            }
            ViajeView().tabItem{
                Label("Viajes", systemImage: "car.side")
            }
             LeaderboardView().tabItem{
                Label("Friends", systemImage: "person.2")
            }
        }
    }
}

#Preview {
    MenuView()
}
