//
//  ActividadView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI

struct ActividadView: View {
    @State var opcion: String
    var body: some View {
        HStack {
            Spacer()
            Text(opcion)
                .padding()
                .padding(.top, 3)
                .padding(.bottom, 3)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(.button, lineWidth: 1)
                .stroke(Color.gray)
                .opacity(0.2)
        )
        

    }
}

#Preview {
    ActividadView(opcion: "Baño")
}
