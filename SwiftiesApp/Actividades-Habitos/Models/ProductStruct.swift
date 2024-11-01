//
//  ProductStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

struct Product : Decodable, Hashable{
    var idproducto : Int
    var nombre : String
    var cantidad : Int
    var unidad : String
}
