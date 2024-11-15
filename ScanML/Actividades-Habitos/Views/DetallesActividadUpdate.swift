import SwiftUI
import Supabase

struct DetallesActividadUpdate: View {
    @State var selectionFrecuency = 0
    @State var selectionTimeUnit = 0

    @State var habitName: String
    var habitid: Int
    @State private var description: String = ""
    @State private var time: Int = 10
    @State private var cantidad: Int = 1

    let mapFrecuencia: [String] = ["Dia", "Semana", "Mes"]
    let mapCantidad: [String] = ["min", "hr"]

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: User

    var disabled: Bool = false

    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")

    init(habito: Habit) {
        self.habitName = habito.nombre
        self.habitid = habito.idhabito
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Nombre").bold()
                    .padding(.vertical, 7)
                TextField(
                    "Nombre de la actividad",
                    text: $habitName
                )
                .padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundStyle(.black)
                .background(Color.gray.opacity(0.2))
                .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                Text("Frecuencia").bold()
                    .padding(.bottom, -20)
                    .padding(.vertical, 7)
                HStack {
                    TextField("Tiempo", value: $time, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .containerShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    Text("Veces por")
                    Picker("Frecuencia", selection: $selectionFrecuency) {
                        Text("Dia").tag(0)
                        Text("Semana").tag(1)
                        Text("Mes").tag(2)
                    }
                    .pickerStyle(.segmented).padding()
                }

                Text("Cantidad").bold()
                    .padding(.bottom, -20)
                    .padding(.vertical, 7)
                HStack {
                    TextField("Tiempo", value: $cantidad, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .frame(width: 200, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .containerShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    
                    Picker("Unidad de tiempo", selection: $selectionTimeUnit) {
                        Text("min").tag(0)
                    }
                    .background(Color.gray.opacity(0.2))
                    .frame(width: 70)
                    .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .tint(.black)
                }.padding(.top)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                Task {
                    do {
                        let updatedHabit = HabitUserToDatabase(
                            idusuario: user.idusuario,
                            idhabito: habitid,
                            recurrencia: mapFrecuencia[selectionFrecuency],
                            frecuencia: time,
                            cantidad: String(cantidad),
                            fechainicio: Date()
                        )
                        // Use `update()` for updating an existing record
                        try await client.from("usuario_habito")
                            .update(updatedHabit)
                            .eq("idhabito", value: habitid)
                            .eq("idusuario", value: user.idusuario)
                            .execute()
                        
                        print("Hábito actualizado exitosamente")
                    } catch {
                        print("Error al actualizar el hábito: \(error.localizedDescription)")
                    }
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Actualizar")
                    .padding(.horizontal)
                    .padding(.vertical, 6)
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
}

#Preview {
    DetallesActividadUpdate(habito: Habit(idhabito: 1, nombre: "Bañarse")).environmentObject(User(idusuario: 1, nombre: "Juan", apellido: "", email: "", contraseña: ""))
}
