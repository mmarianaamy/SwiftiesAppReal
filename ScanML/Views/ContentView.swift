//
//  ContentView.swift
//  SwiftiesApp
//
//  Created by Alumno on 08/10/24.
//

import SwiftUI
import Supabase


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

struct userHold : Observable, Decodable, Hashable {
    var idusuario: Int
    var nombre: String
    var apellido: String
    var email: String
    var contraseña: String
}

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
    
    func changeValue(email : String) async {
        let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
        
        do{
            let hold : [userHold]? = try await client.from("usuario").select("idusuario, nombre, apellido,email,contraseña").eq("email", value: email).execute().value

        }catch{
            print("No se pudo guardar el usuario")
        }
    }
    
}

struct ContentView: View {
    @State var logged = false
    //@EnvironmentObject var user: User
    
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

//Users/carolinaresendz/Documents/SwiftiesAppReal/SwiftiesApp/Views/ContentView.swift:67:26 Missing argument for parameter 'user' in call



#Preview {
    ContentView().environmentObject(User())
}
