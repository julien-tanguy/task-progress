//
//  ContentView.swift
//  Task Progress
//
//  Created by julien tanguy on 04/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Picker
    enum TaskFilter: String, CaseIterable, Identifiable {
        case all, done, notDone
        var id: Self { self }
    }
    @State private var selectedFilter: TaskFilter = .all
    // Toutes les Tasks
    @Query var tasks: [Task]
    //Tasks términées
    @Query(filter: #Predicate<Task> { task in
        task.isDone == true
    }) var tasksIsDone: [Task]
    //Tasks non términées
    @Query(filter: #Predicate<Task> { task in
        task.isDone == false
    }) var tasksNoDone: [Task]
    //@State private var selectedTask: [Task] = tasks
    @State private var showAddTaskView = false
    // Obligatoire si tu veux interagir avec SwiftData dans la vue
    @Environment(\.modelContext) var modelContext
    
    private var filteredTasks: [Task] {
        switch selectedFilter {
        case .all:
            return tasks
        case .done:
            return tasksIsDone
        case .notDone:
            return tasksNoDone
        }
    }
    
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
        if tasks.isEmpty {
            List {
                Text("Aucune tâches a afficher")
            }
        }else{
            Text ("Tâches terminées : \(tasksIsDone.count) / \(tasks.count)")
            Picker("Tâches", selection: $selectedFilter) {
                    Text("Toutes").tag(TaskFilter.all)
                    Text("En cours").tag(TaskFilter.notDone)
                    Text("Terminées").tag(TaskFilter.done)
                }
            List {
                ForEach(filteredTasks) { task in
                    HStack {
                        Button(action: {
                            taskIsDone(task: task)
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
    
    // MARK: - Actions
    
    func taskIsDone(task: Task) {
        task.isDone.toggle()
        try?  modelContext.save()
    }
}

#Preview {
    ContentView()
}

