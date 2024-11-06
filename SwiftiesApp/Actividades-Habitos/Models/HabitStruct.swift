//
//  HabitStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import Foundation

struct Habit : Hashable, Identifiable, Codable{
    var id = UUID()
    var frecuency : Int
    var name : String
    var date: Date
}

struct Event: Identifiable{
    var id : Int
    var name: String
    var date: Date
}

struct HabitUser {
    var recurrencia : String
    var frecuencia : Int
    var cantidad : String
    var idusuario : Int
    /*var fechainicio : Date
    var fechafinal : Date*/
    /*var nombre : String*/
}
