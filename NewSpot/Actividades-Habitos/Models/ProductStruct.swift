//
//  ProductStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

import Foundation

struct Product : Decodable, Hashable{
    var idproducto : Int
    var nombre : String
    var cantidad : Int
    var unidad : String
}

struct UsuarioProduct : Decodable, Hashable {
    var idup : Int
    var cantidad : Float
    var fecha : String
    var idusuario : Int
    var idproducto : Int
    var producto : Product
}
/*

struct User: Codable {
    let idusuario: Int
    let nombre: String
    let apellido: String
    let email: String
    let contraseña: String
    let habits: [HabitoHuella]
    let habits: [HabitoHuella]
    
    struct Habito: Codable {
        let idhabito: Int
        let nombre: String
        let cantidad: Int
        let unidad: String
    }
    
    struct Huella: Codable {
        let idhuella: Int
        let nombre: String
        let unidad: Double
    }
    
    struct HabitoHuella: Codable {
        let idhabito_huella: Int
        let idhabito: Int
        let idhuella: Int
        let valorimpacto: Double
    }
    
    struct UsuarioHabito: Codable {
        let idusuario_habito: Int
        let idusuario: Int
        let idhabito: Int
        let recurrencia: String
        let frecuencia: String
        let cantidad: Int
        let fechainicio: String
        let fechafinal: String
    }
}

struct Team: Codable {
  let id: Int
  let name: String
  let users: [User]

  struct User: Codable {
    let id: Int
    let name: String
  }

  enum CodingKeys: String, CodingKey {
    case id, users
    case name = "team_name"
  }
}
let teams [Team] = try await supabase
  .from("teams")
  .select(
    """
      id,
      team_name,
      users ( id, name )
    """
  )
  .execute()
  .value
*/
