//
//  SettingRow.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 14/11/24.
//

import SwiftUI

struct SettingRow: View {
    var imagen: String
    var texto: String
    
    var body: some View {
        
        HStack {
            Image(systemName: imagen)
            Text(texto)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 0.2))
            
            
        }.padding(.horizontal)
    }
}

#Preview {
    SettingRow(imagen: "person.circle", texto: "Perfil")
}
