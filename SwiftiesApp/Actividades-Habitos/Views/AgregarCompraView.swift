//
//  AgregarCompraView.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

import SwiftUI

struct UsuarioProductToDatabase : Observable, Codable{
    var idusuario : Int
    var idproducto : Int
    var cantidad : Float
    var fecha : Date
}

struct AgregarCompraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var page : Int = 0
    @State var selectedProduct : Int = -1
    @State var count : Float = 1
    
    @EnvironmentObject var user : User
    
    var tipo : String = "P"
    
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
                BuscarProductoView(selectedProduct: $selectedProduct, tipo: tipo, page: $page)
            }
            else{
                VStack{
                    Text("Ingresa cantidad")
                    HStack{
                        Button{
                            count += 1
                        } label: {
                            Text("+")
                        }
                        .font(.title)
                            .foregroundStyle(Color.white)
                            .frame(width: 50, height: 50)
                            .background(Color.background)
                            .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        HStack{
                            TextField("1", value: $count, format: .number).multilineTextAlignment(.center)
                        }.frame(maxWidth: .infinity)
                        Button{
                            if count > 1{
                                count -= 1
                            }
                        } label: {
                            Text("-")
                        }.font(.title)
                            .foregroundStyle(Color.white)
                            .frame(width: 50, height: 50)
                            .background(Color.background)
                            .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }.padding(40)
                    Button{
                        print("hi")
                        Task{
                            do{
                                try await supabase
                                    .from("usuario_producto")
                                    .insert(UsuarioProductToDatabase(idusuario: user.idusuario, idproducto: selectedProduct, cantidad: count, fecha: Date()))
                                    .execute()
                                print("added compra")
                            }catch{
                                print("not added compra")
                                print(error)
                            }
                            
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Listo")
                    }
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    AgregarCompraView(page: 1, selectedProduct: 3).environmentObject(User(idusuario: 11))
}
