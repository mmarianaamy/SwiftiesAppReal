//
//  EmissionsViewModel.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 05/11/24.
//

import Foundation
import SwiftUI

class TotalEmissionViewModel: ObservableObject {
    @Published var emissionsData: [Emissions] = []

    private let apiURL = "https://hyufiwwpfhtovhspewlc.supabase.co/rest/v1/user_product"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc"

    func fetchEmissions(for userID: Int) {
        let urlString = "\(apiURL)?select=fecha,cantidad,producto_huella(huella(nombre))&idusuario=eq.\(userID)"
        
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var emissionTotals = ["Hidrica": 0.0, "Carbono": 0.0, "Electrica": 0.0]

                    for item in jsonResponse {
                        if let footprintType = item["producto_huella"] as? [String: Any],
                           let huella = footprintType["huella"] as? [String: Any],
                           let nombre = huella["nombre"] as? String,
                           let cantidad = item["cantidad"] as? Double {
                            
                            emissionTotals[nombre, default: 0.0] += cantidad
                        }
                    }

                    DispatchQueue.main.async {
                        self?.emissionsData = emissionTotals.map { Emissions(type: $0.key, emissions: $0.value) }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
}
