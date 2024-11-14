//
//  addHabit.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 13/11/24.
//

import AppIntents


///Creo que para que siri los reconozca tienen que estar en ingles (?)
struct AddHabitIntent: AppIntent {
    
    static var title = LocalizedStringResource("Add a new habit")
    
    @Parameter(title: "Habit")
    var habitName: String
    
    func perform() async throws -> some IntentResult {
        ///Sin la opcion de añadir habitos personalizados esto no hace sentido
        //HabitViewModel.shared.addHabit(habitName: habitName)
        return .result()
    }
}
