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
            /* Parte de segundo sprint
             LeaderboardView().tabItem{
                Label("Friends", systemImage: "person")
            }*/
        }
    }
}

#Preview {
    MenuView()
}
