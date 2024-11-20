//
//  ActListItem.swift
//  New Spot
//
//  Created by Alumno on 20/11/24.
//

import SwiftUI
import Supabase

struct ActListItem: View {
    var usuarioProducto : UsuarioProduct
    @EnvironmentObject var user: User
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
    var body: some View {
        Text(usuarioProducto.producto.nombre)
            .swipeActions(allowsFullSwipe: false) {
                
                Button(role: .destructive) {
                    deleteActividad()
                } label: {
                    Label("Eliminar", systemImage: "trash.fill")
                }
                
                NavigationLink {
                    AgregarCompraView(selectedProduct: usuarioProducto.idproducto, updating: true)
                                           
                } label: {
                    Button {
                        print("Editar")
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                    .tint(.yellow)
                }
            }
    }

    private func deleteActividad() {
        Task {
           do {
                try await client.from("usuario_producto")
                    .delete()
                    .eq("idproducto", value: usuarioProducto.idproducto)
                    .eq("idusuario", value: user.idusuario)
                    .execute()
                print("Producto eliminado exitosamente")
                
            } catch {
                print("Error al eliminar el hábito: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            ActListItem(usuarioProducto: UsuarioProduct(idup: 1, cantidad: 1, fecha: "2024-11-11", idusuario: 11, idproducto: 3, producto: Product(idproducto: 3, nombre: "Carne de res", cantidad: 1, unidad: "")))
        }
    }.environmentObject(User(idusuario: 11))
}
