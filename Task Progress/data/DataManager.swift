//
//  DataManager.swift
//  Task Progress
//
//  Created by julien tanguy on 04/01/2026.
//

import SwiftData
import SwiftUI

@MainActor
class DataManager {
    
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func addTask(title: String){
        let addTaskInsert = Task(title: title, isDone: false)
        context.insert(addTaskInsert)
        try? context.save()
    }
    
    func taskIsDone(task: Task) {
        task.isDone.toggle()
        try?  context.save()
    }
}
