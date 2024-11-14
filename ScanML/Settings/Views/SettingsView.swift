//
//  SettingsView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 14/11/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            topView(title: "Configuración")
            VStack{
                NavigationLink{ProfileView().navigationTitle("Perfil")} label: {SettingRow(imagen: "person.circle", texto: "Perfil")}.tint(Color.black)
                
                SettingRow(imagen: "lock", texto: "Privacidad")
                SettingRow(imagen: "person.2.badge.plus.fill", texto: "Invitar a un amigo")
                Spacer()
            }.padding(.top)
        }
    }
}

#Preview {
    SettingsView()
}
