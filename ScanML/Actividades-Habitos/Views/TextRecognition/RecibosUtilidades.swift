//
//  Recibos.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 12/11/24.
//

import SwiftUI

struct RecibosUtilidades: View {
    var body: some View {
        
        NavigationStack {
            
            VStack (alignment: .leading){
                Text("Selecciona una utilidad")
                    .font(.title2)
                    .padding(.bottom, 20)
                    .bold()
                
                Text("Para garantizar que la información sea correcta, recomendamos subir una foto de tu recibo digital. Sin embargo, si esto no te es posible, también puedes usar una foto de tu recibo físico.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 50)
            }.padding()
            
            
            
            VStack (spacing: 13){
                NavigationLink(destination: TextRecognitionElectricidad()) {
                    Label("Electricidad", systemImage: "lightbulb")
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.customYellowButton))
                }
                .frame(width: 200)
                
                
                NavigationLink(destination: TextRecognitionAgua()) {
                    Label("Agua", systemImage: "drop")
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.customBlueButton))
                }
                .frame(width: 200)
                
                
                NavigationLink(destination: TextRecognitionGas()) {
                    Label("Gas", systemImage: "flame")
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.customGreenButton))
                }
                .frame(width: 200)
            }
            Spacer()
        }
    }
}

#Preview {
    RecibosUtilidades()
}
