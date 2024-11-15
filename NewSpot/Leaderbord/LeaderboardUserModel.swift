//
//  LeaderboardUser.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import Foundation

struct amigoUser : Decodable, Hashable {
    var idusuario: Int?
    var nombre: String?
}

struct LeaderboardUser: Hashable, Decodable {
    let idamigos : Int
    let idusuario : Int
    let idamigo : Int
    let user : [amigoUser]?
}
