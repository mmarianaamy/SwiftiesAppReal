//
//  BuscarProductoView.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

import SwiftUI

struct BuscarProductoView: View {
        
    @State var searchText : String = ""
    let products : [Product] = [Product(id: 1, nombre: "Huevo"), Product(id: 2, nombre: "Leche"), Product(id: 3, nombre: "Carbon"), Product(id: 4, nombre: "Gasolina"), Product(id: 5, nombre: "Computadora"), Product(id: 6, nombre: "Agua"), Product(id: 7, nombre: "Sillon"), Product(id: 8, nombre: "Carro"), Product(id: 9, nombre: "Huevos"), Product(id: 10, nombre: "asjdklf"), Product(id: 11, nombre: "ajskld")]
    
    @State var selectedProduct : Int = -1
    
    @State var selected : Bool = false
    
    var searchResults: [Product] {
        if searchText.isEmpty{
            return products
        }
        return products.filter{$0.nombre.contains(searchText)}
    }
    
    @Binding var page : Int

    var body: some View {
        ZStack{
            VStack{
                TextField("Buscar", text: $searchText)
                    .padding()
                    .border(Color.gray)
                    .padding()
                    .autocorrectionDisabled()
                ScrollView{
                    ForEach(searchResults){product in
                        Button{
                            selectedProduct = product.id
                            selected = true
                        } label: {
                            HStack{
                                Text(product.nombre).foregroundStyle(Color.black)
                            }.padding().frame(maxWidth: .infinity).border(product.id == selectedProduct ? Color.blue : Color.gray)
                        }
                        
                    }
                }.padding()
            }
            if selected {
                VStack{
                    Spacer()
                    Button{
                        page += 1
                    }label: {
                        Text("Siguiente").foregroundStyle(Color.white).padding()
                    }.background(Color.background)
                }.padding()
            }
        }
    }
}

#Preview {
    AgregarCompraView()
}
