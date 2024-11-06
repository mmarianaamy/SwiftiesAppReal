//
//  ContentView.swift
//  SwiftiesApp
//
//  Created by Alumno on 08/10/24.
//

import SwiftUI


/*class User : ObservableObject{

    init(idusuario: Int = 0, nombre: String = "", apellido: String = "", email: String = "", contraseña: String = "") {
        self.idusuario = idusuario
        self.nombre = nombre
        self.apellido = apellido
        self.email = email
        self.contraseña = contraseña
    }
    
    var idusuario : Int
    var nombre: String
    var apellido : String
    var email : String
    var contraseña : String
}

struct ContentView: View {
    @State var logged = false
    
    @State var user : User = User()
    
    var body: some View {
        if !logged{
            LoginPage(logged: $logged, user: $user)
        }else{
            MenuView(user: $user)
        }
    }
}*/

class User: ObservableObject {
    @Published var idusuario: Int
    @Published var nombre: String
    @Published var apellido: String
    @Published var email: String
    @Published var contraseña: String
    
    init(idusuario: Int = 0, nombre: String = "", apellido: String = "", email: String = "", contraseña: String = "") {
        self.idusuario = idusuario
        self.nombre = nombre
        self.apellido = apellido
        self.email = email
        self.contraseña = contraseña
    }
}

struct ContentView: View {
    @State var logged = false
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationStack{
            if !logged {
                LoginPage(logged: $logged) // Pass `logged` as a binding
            } else {
                MenuView()
            }
        }
    }
}
 


#Preview {
    ContentView()
}
