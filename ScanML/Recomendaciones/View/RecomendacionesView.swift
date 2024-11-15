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
            let habitsString = habits.compactMap { $0.habito?.nombre }.joined(separator: ", ")
            // MARK: Debug -----
            print(habitsString)
            response = try await self.generativeModel.generateContent(
                "Dame un máximo de 4 sugerencias pare reducir el impacto \(tipo) de una persona que tiene los siguientes habitos: \(habitsString). Deben de ser sugerencias que hagan sentido. No tienes que dar 4 obligatoriamente. Dámelo en formato JSON. No incluyas texto adicional. Unicamente regresa el diccionario. Empezando con { y terminando con }. El formato debe de ser una clave sugerencia. Cada elemento del arreglo es un objeto que tiene dos claves: actividad y sugerencia. Devuélvelo estrictamente en formato JSON sin caracteres de escape o de formato adicional."
            )
            
            if let responseText = response?.text {
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
                Text("hola")
                    .task {
                        do {
                            habits = try await client.from("usuario_habito")
                                .select("recurrencia, frecuencia, cantidad, idhabito, fechainicio, fechafinal, habito(idhabito, nombre)")
                                .eq("idusuario", value: user.idusuario).execute().value
                            
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
                    if !responseTextField.isEmpty {
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
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        if tipo == "Hídrico" {
                            RecomendacionItemView(titulo: "Reduce el consumo de carne y lácteos", descripcion: "La producción de carne y lácteos requiere grandes cantidades de agua. Reducir su consumo ayuda a ahorrar agua.")
                            RecomendacionItemView(titulo: "Toma duchas cortas (máximo 5 minutos)", descripcion: "Reducir el tiempo de ducha puede ahorrar una cantidad significativa de agua diaria.")
                            RecomendacionItemView(titulo: "Instala inodoros de descarga dual", descripcion: "Los inodoros de descarga dual permiten elegir entre dos niveles de descarga, lo que reduce el uso innecesario de agua.")
                            RecomendacionItemView(titulo: "Utiliza sistemas de riego por goteo", descripcion: "Los sistemas de riego por goteo son más eficientes que el riego tradicional, reduciendo el desperdicio de agua.")
                        } else if tipo == "Energético" {
                            RecomendacionItemView(titulo: "Apaga las luces al salir de una habitación", descripcion: "Apagar las luces cuando no se usan reduce el consumo de electricidad y mejora la eficiencia energética.")
                            RecomendacionItemView(titulo: "Usa electrodomésticos eficientes", descripcion: "Los electrodomésticos eficientes consumen menos energía, ayudando a reducir tu huella energética.")
                            RecomendacionItemView(titulo: "Utiliza energía renovable", descripcion: "Optar por energía renovable como la solar o eólica reduce las emisiones de CO2 y depende menos de fuentes no renovables.")
                        } else if tipo == "Carbono" {
                            RecomendacionItemView(titulo: "Utiliza transporte público o bicicleta", descripcion: "El transporte público y la bicicleta emiten menos CO2 que los vehículos privados, ayudando a reducir tu huella de carbono.")
                            RecomendacionItemView(titulo: "Planta árboles para compensar emisiones", descripcion: "Los árboles absorben CO2, contribuyendo a compensar las emisiones de carbono generadas por otras actividades.")
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
