//
//  ActividadesModel.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 17/10/24.
//

import Foundation

struct Actividad : Identifiable{
    var id : Int
    var name : String
}

var actividades: [Actividad]  = [Actividad(id: 1, name: "Baño"), Actividad(id: 2, name: "Lavar trastes") , Actividad(id: 3, name: "Poner la lavadora") , Actividad(id: 4, name: "Prender el clima") , Actividad(id: 5, name: "Comprar comida"), Actividad(id: 6, name: "Otro")]
