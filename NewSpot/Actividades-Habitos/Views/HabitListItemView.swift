//
//  HabitListItemView.swift
//  SwiftiesApp
//
//  Created by Alumno on 11/10/24.
//

import SwiftUI
import Supabase

struct HabitListItem: View {
    var habit: HabitUser
    @EnvironmentObject var user: User
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
    var body: some View {
        Text(habit.habito?.nombre ?? "Hábito")
            .swipeActions(allowsFullSwipe: false) {
                
                Button(role: .destructive) {
                    deleteHabit()
                } label: {
                    Label("Eliminar", systemImage: "trash.fill")
                }
                
                NavigationLink {
                    DetallesActividadUpdate(habito: habit.habito ?? Habit(idhabito: 0, nombre: ""))
                                           
                } label: {
                    Button {
                        print("Editar")
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                    .tint(.yellow)
                }
            }
    }

    private func deleteHabit() {
        Task {
            do {
                try await client.from("usuario_habito")
                    .delete()
                    .eq("idhabito", value: habit.idhabito)
                    .eq("idusuario", value: user.idusuario)
                    .execute()
                print("Hábito eliminado exitosamente")
                
            } catch {
                print("Error al eliminar el hábito: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            HabitListItem(habit: HabitUser(recurrencia: "dia", frecuencia: 7, cantidad: 2, idhabito: 1, fechainicio: "Date()", fechafinal: nil, habito: Habit(idhabito: 1, nombre: "")))
        }
    }
}
