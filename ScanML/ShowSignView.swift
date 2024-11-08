//
//  ShowSignView.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 15/10/23.
//

import SwiftUI

struct ShowSignView: View {
    private(set) var labelData: Classification
    
    var body: some View {
                
            Text(labelData.label.capitalized)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.background)
                .font(.title)
                .background(Color.white)
                .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
    }
}
