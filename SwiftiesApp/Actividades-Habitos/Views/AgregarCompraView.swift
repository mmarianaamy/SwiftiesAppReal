//
//  AgregarCompraView.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

import SwiftUI

struct AgregarCompraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var page : Int = 0

    var body: some View {
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Salir")
                }
                Spacer()
            }.padding()
            if page == 0{
                BuscarProductoView(page: $page)
            }
            else{
                Text("Ingresa cantidad")
            }
        }
    }
}

#Preview {
    AgregarCompraView()
}
