//
//  HabitStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import Foundation

struct Habit : Hashable, Codable{
    var idhabito : Int
    var nombre : String
}

struct Event: Identifiable{
    var id : Int
    var name: String
    var date: Date
}

struct HabitUser : Decodable, Hashable {
    var recurrencia : String
    var frecuencia : Int
    var cantidad : String
    var idhabito : Int
    var fechainicio : String
    var fechafinal : String?
    var habito : Habit
}
