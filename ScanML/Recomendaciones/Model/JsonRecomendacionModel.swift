//
//  JsonRecomendacionModel.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 14/11/24.
//

import Foundation

struct Sugerencia: Decodable, Identifiable {
    var id = UUID()
    let actividad: String
    let sugerencia: String

    enum CodingKeys: String, CodingKey {
        case actividad = "actividad"
        case sugerencia = "sugerencia"
    }
}

struct Response: Decodable {
    let sugerencias: [Sugerencia]

    enum CodingKeys: String, CodingKey {
        case sugerencias = "sugerencias"
    }
}
