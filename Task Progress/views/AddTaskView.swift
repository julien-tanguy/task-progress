//
//  AddTaskView.swift
//  Task Progress
//
//  Created by julien tanguy on 04/01/2026.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    // Permet de récupérer l'action de fermeture de la vue dans l’environnement (grâce à SwiftUI)
    @Environment(\.dismiss) var dismiss
    // Obligatoire si tu veux interagir avec SwiftData dans la vue
    @Environment(\.modelContext) var modelContext
    var task: Task
    @State var title: String = ""
    var body: some View {
        let isDisabled = title.isEmpty
        
        VStack(alignment: .leading) {
            Text("ajouter une tâche")
                .font(.largeTitle)
                .padding()
                .bold()
                .foregroundColor(.primary)
            Form {
                Section("Titre") {
                    TextField("Titre", text: $title)
                        .padding(10)
                        .cornerRadius(10)
                }
            }
            HStack {
                Button {
                   handleSave()
                } label: {
                    Text("Ajouter")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                        .background(
                            isDisabled
                            ? LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.4)]),
                                startPoint: .leading,
                                endPoint: .trailing
                              )
                            : LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                              )
                        )
                        .cornerRadius(25)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .disabled(isDisabled)
                .animation(.easeInOut(duration: 0.6), value: isDisabled)
            }
            .padding()
        }
    }
    
    func handleSave(){
        let dataManager = DataManager(context: modelContext)
        dataManager.addTask(title: title)
        dismiss()
    }
}
#Preview {
    AddTaskView(task: Task(title: "test", isDone: false))
}

