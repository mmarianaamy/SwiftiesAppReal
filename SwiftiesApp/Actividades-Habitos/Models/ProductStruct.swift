//
//  ProductStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 30/10/24.
//

struct Producto : Decodable, Hashable{
    var idproducto : Int
    var nombre : String
    var cantidad : Int
    var unidad : String
}

struct UsuarioProduct : Decodable, Hashable {
    var cantidad : Float
    var fecha : String
    var idusuario : Int
    var idproducto : Int
    var producto : Producto
}
