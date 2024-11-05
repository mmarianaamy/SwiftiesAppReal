//
//  UsuarioStruct.swift
//  SwiftiesApp
//
//  Created by Carolina De los Santos Reséndiz on 17/10/24.
//

import Foundation

struct Usuario: Identifiable, Codable {
    var id: Int
    var nombre: String
    var apellido: String
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idusuario"
        case nombre
        case apellido
        case email
    }
}

