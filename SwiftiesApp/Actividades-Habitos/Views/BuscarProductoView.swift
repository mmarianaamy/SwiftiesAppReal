//
//  BuscarProductoView.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

import SwiftUI

struct BuscarProductoView: View {
        
    @State var searchText : String = ""
    let products : [Product] = []
    
    @Binding var selectedProduct : Int
    
    @State var selected : Bool = false
    
    @State var productosGuardados : [Product] = []
    
    var searchResults: [Product] {
        if searchText.isEmpty{
            return productosGuardados
        }
        return productosGuardados.filter{$0.nombre.lowercased().contains(searchText.lowercased())}
    }
    
    @Binding var page : Int
    
    private let apiURL = "https://hyufiwwpfhtovhspewlc.supabase.co/rest/v1/producto"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc"
    
    @State var isLoading : Bool = true
    @State var errorMessage : String = ""
    
    func getItems() async -> [Product] {
        
        var productos : [Product] = []
        
        guard let url = URL(string: "\(apiURL)?select=*") else {
            print("URL inválida")
            return productos
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        isLoading = true
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            productos = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            productos = []
        }

        isLoading = false
        print(self.errorMessage)
        return productos
    }

    var body: some View {
        ZStack{
            VStack{
                TextField("Buscar", text: $searchText)
                    .padding()
                    .border(Color.gray)
                    .padding()
                    .autocorrectionDisabled().task{
                        self.productosGuardados = await getItems()
                    }
                if isLoading{
                    ProgressView()
                }else{
                    ScrollView{
                        ForEach(searchResults, id: \.self){product in
                            Button{
                                selectedProduct = product.idproducto
                                selected = true
                            } label: {
                                HStack{
                                    Text(product.nombre)
                                    if product.unidad != ""{
                                        Divider()
                                        Text(String(product.cantidad) + product.unidad)
                                    }
                                }.padding().frame(maxWidth: .infinity).border(product.idproducto == selectedProduct ? Color.blue : Color.gray).foregroundStyle(Color.black)
                            }
                            
                        }
                    }.padding()
                }
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
