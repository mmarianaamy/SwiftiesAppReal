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
    @State var selectedProduct : Int = -1
    @State var count : Int = 1
    
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
                BuscarProductoView(selectedProduct: $selectedProduct, page: $page)
            }
            else{
                VStack{
                    Text("Ingresa cantidad")
                    Button{
                        count += 1
                    } label: {
                        Text("+")
                    }
                    HStack{
                        TextField("1", value: $count, format: .number).multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                    Button{
                        if count > 1{
                            count -= 1
                        }
                    } label: {
                        Text("-")
                    }
                }
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Listo")
                }
            }
        }
    }
}

#Preview {
    AgregarCompraView(page: 1)
}
