//
//  JsonRecomendacionVM.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 14/11/24.
//

import Foundation

func parseSugerencias(jsonData: Data) {
    do {
        // Attempt to parse the JSON using JSONSerialization to confirm the format
        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
           let sugerencias = json["sugerencias"] as? [[String: String]] {
            print("Manually parsed sugerencias: \(sugerencias)")
        } else {
            print("Error: Unable to manually parse JSON.")
        }
        
        // Now decode using the original model to check if it works
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: jsonData)
        let sugerencias = response.sugerencias
        
        // Print each suggestion to verify it's populated correctly
        for sugerencia in sugerencias {
            print("Actividad: \(sugerencia.actividad), Sugerencia: \(sugerencia.sugerencia)")
        }
        
    } catch {
        print("Error decoding JSON: \(error.localizedDescription), \(error)")
    }
}

