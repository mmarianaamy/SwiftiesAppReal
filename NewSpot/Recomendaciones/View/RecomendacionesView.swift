//
//  RecomendacionesAIView.swift
//  New Spot
//
//  Created by Jorge Salcedo on 10/11/24.
//

import SwiftUI
import Supabase
import GoogleGenerativeAI

struct RecomendacionesView: View {
    var tipo: String
    @EnvironmentObject var user: User
    @State var habits: [HabitUser] = []
    @State var sugerencias: [Sugerencia] = []
    
    // MARK: BD
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
    // MARK: AI
    @State private var responseTextField: String = ""
    private let generativeModel = GenerativeModel(
        name: "gemini-1.5-flash",
        apiKey: "AIzaSyC1H8wcDSNVY-OdrIkWfGFUuwROo-NRVe8"
    )
    @State var response: GenerateContentResponse?
    
    func respond() async -> String {
        do {
            let habitsString = habits.map {
                "\($0.habito?.nombre ?? "N/A")  \($0.frecuencia) veces por \($0.recurrencia), por \($0.cantidad) minutos"
            }.joined(separator: "; ")
            // MARK: Debug -----
            print("\n Habitos:")
            print(habitsString)
            print("\n")
            if tipo == "Hídrico" {
                response = try await self.generativeModel.generateContent(
                    "Dame un máximo de 4 sugerencias pare reducir el impacto hidrico de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional. Enfocate en cosas que reduzcan la huella hidrica. Cosas relacionadas al agua. Las sugerencias deben incluir acciones como el ahorro de agua")
                print("PROMPT AGUA \n")
                print(
                    "Dame un máximo de 4 sugerencias pare reducir el impacto hidrico de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional. Enfocate en cosas que reduzcan la huella hidrica. Cosas relacionadas al agua. Las sugerencias deben incluir acciones como el ahorro de agua \n")
            }
            else if tipo == "Energético" {
                response = try await self.generativeModel.generateContent(
                    "Dame un máximo de 4 sugerencias pare reducir el impacto electrico de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional. Las sugerencias deben centrarse en eficiencia energética. Solo incluye cosas de agua si directamente se relacionan con el consumo de electricidad")
                print("PROMPT ELECTRICIDAD")
                print(
                    " \n Dame un máximo de 4 sugerencias pare reducir el impacto electrico de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional. Las sugerencias deben centrarse en eficiencia energética. Solo incluye cosas de agua si directamente se relacionan con el consumo de electricidad \n")
            }
            else if tipo == "Carbono"{
                response = try await self.generativeModel.generateContent(
                    "Dame un máximo de 4 sugerencias pare reducir la huella de carbono de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional. Las sugerencias deben centrarse reducir las emisiones de carbono de la persona. Solo incluye cosas de agua si directamente se relacionan con el consumo de electricidad")
                print("PROMPT CARBONO")
            }
            
                
            
            if let responseText = response?.text {
                print("RESPUESTA: \(responseText)")
                return responseText
            } else {
                throw MyError.runtimeError("No response text available.")
            }
            
        } catch {
            // Log the error and return an empty string if something goes wrong
            print("Error: \(error)")
            return ""
        }
    }
    
    func parseSugerencias(jsonData: Data) {
        let decoder = JSONDecoder()
        
        do {
            // Decode the JSON response into a list of sugerencias
            let response = try decoder.decode([Sugerencia].self, from: jsonData)
            // Save the parsed suggestions into sugerencias
            sugerencias = response
            
            // Print the sugerencias to verify it's populated correctly
            print("Parsed Sugerencias: \(sugerencias)")
        } catch {
            // Print any decoding errors
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("hola").hidden()
                    .task {
                        do {
                            habits = try await client.from("usuario_habito")
                                .select("recurrencia, frecuencia, cantidad, idhabito, fechainicio, fechafinal, habito(idhabito, nombre)")
                                .eq("idusuario", value: user.idusuario).execute().value
                            
                            print("\n Fetched habits as appear on the database: \n \(habits)")
                            
                            // Fetching AI response
                            let textResponse = await respond()
                            responseTextField = textResponse
                            
                            // Log the raw response to verify it
                            print("Raw AI response: \(responseTextField)")
                            
                            // Attempt to decode the string as JSON
                            let cleanResponse = responseTextField.trimmingCharacters(in: .whitespacesAndNewlines)
                            if let jsonData = responseTextField.trimmingCharacters(in: .whitespacesAndNewlines).data(using: .utf8) {
                                do {
                                    // Validate the structure with JSONSerialization
                                    if let _ = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                        // Decode with JSONDecoder if valid
                                        let decoder = JSONDecoder()
                                        let parsedResponse = try decoder.decode(Response.self, from: jsonData)
                                        sugerencias = parsedResponse.sugerencias
                                        print("Successfully decoded JSON.")
                                        print("SUGERENCIAS: ", sugerencias)
                                    } else {
                                        print("Error: JSON structure is not valid.")
                                    }
                                } catch {
                                    print("Error decoding JSON: \(error.localizedDescription)")
                                }
                            } else {
                                print("Error: Unable to convert string to data.")
                            }
                            
                        } catch {
                            print("Error fetching habits: \(error)")
                        }
                    }
                ScrollView {
                    //MARK: DEBUG ---
                    /*if !responseTextField.isEmpty {
                        TextField("Consumo de agua total del recibo:", text: $responseTextField)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .onAppear {
                                Task {
                                    await respond()
                                }
                            }
                    }*/
                    VStack(alignment: .leading, spacing: 10) {
                        if tipo == "Hídrico" {
                            ForEach(sugerencias) { sugerencia in
                                RecomendacionItemView(titulo: sugerencia.actividad, descripcion: sugerencia.sugerencia)
                            }
                        } else if tipo == "Energético" {
                            ForEach(sugerencias) { sugerencia in
                                RecomendacionItemView(titulo: sugerencia.actividad, descripcion: sugerencia.sugerencia)
                            }
                        } else if tipo == "Carbono" {
                            ForEach(sugerencias) { sugerencia in
                                RecomendacionItemView(titulo: sugerencia.actividad, descripcion: sugerencia.sugerencia)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct RecomendacionesView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendacionesView(tipo: "Hídrico")
            .environmentObject(User(idusuario: 16, nombre: "teeeeest", apellido: "Doe", email: "test@test.com", contraseña: "test"))
    }
}
