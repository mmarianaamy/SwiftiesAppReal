//
//  HabitStruct.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import Foundation

struct Habit : Identifiable{
    var id : Int
    var frecuency : Int
    var name : String
    var date: Date
}

struct Event: Identifiable{
    var id : Int
    var name: String
    var date: Date
}
