//
//  test.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 06/11/24.
//

/*
import SwiftUI
import Supabase

struct Test: View {
        
    @State var searchText : String = ""
    let products : [HabitFootprint] = []
    
    @Binding var selectedProduct : Int
    
    @State var selected : Bool = false
    
    @State var productosGuardados : [HabiFootprint] = []
    
    var searchResults: [HabiFootprint] {
        return productosGuardados
    }
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
    @Binding var page : Int
    
    @State var isLoading : Bool = true
    @State var errorMessage : String = ""

    var body: some View {
        ZStack{
            VStack{
                TextField("Buscar", text: $searchText)
                    .padding()
                    .border(Color.gray)
                    .padding()
                    .autocorrectionDisabled().task{
                        do{
                            print("here")
                            productosGuardados = try await client.from("habito_huella")
                                .select().execute().value
                            print(productosGuardados)
                            print("done")
                        } catch{
                            print("Not possible")
                        }
                        isLoading = false
                    }
                if isLoading{
                    ProgressView()
                }else{
                    ScrollView{
                        ForEach(productosGuardados, id: \.self){product in
                            Button{
                                selectedProduct = product.idhabito_huella
                                selected = true
                            } label: {
                                HStack{
                                    Text(product.idhabito_huella)
                                    if product.unidad != ""{
                                        Divider()
                                        Text(String(product.cantidad) + product.unidad)
                                    }
                                }.padding().frame(maxWidth: .infinity).border(product.idhabito_huella == selectedProduct ? Color.blue : Color.gray).foregroundStyle(Color.black)
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
    Test(selectedProduct: .constant(1), page: .constant(1))
}
*/
