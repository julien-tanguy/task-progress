//
//  ContentView.swift
//  Task Progress
//
//  Created by julien tanguy on 04/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var tasks: [Task]
    @State private var showAddTaskView = false
    // Obligatoire si tu veux interagir avec SwiftData dans la vue
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Task Progress")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                Spacer()
                Button {
                    showAddTaskView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding(8)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
        .sheet(isPresented: $showAddTaskView){
            AddTaskView(task: Task(title: "test", isDone: false))
        }
        List{
            ForEach(tasks){
                task in
                HStack {
                    Button(action: {
                        let dataManager = DataManager(context: modelContext)
                        dataManager.taskIsDone(task: task)
                    }) {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isDone ? .green : .gray)
                            .font(.title2)
                    }
                    Text(task.title)
                }
            }
        }
       
    }
}

#Preview {
    ContentView()
}
