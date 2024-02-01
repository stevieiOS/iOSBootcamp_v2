//
//  Model.swift
//  List
//
//  Created by Stevie on 1/23/24.
//

import Foundation
import SwiftUI
// Data Model

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var notes: String
    var isCompleted: Bool
}


class Store: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        createSampleTasks()
    }
    
    func createSampleTasks() {
        let sampleTasks = [
            Task(title: "Eat Dinner", notes: "", isCompleted: false),
            Task(title: "Workout", notes: "Biceps", isCompleted: true),
            Task(title: "Read", notes: "Junji Ito", isCompleted: false),
            Task(title: "Study", notes: "Kodeco", isCompleted: true),
            Task(title: "Skateboard", notes: "", isCompleted: false)
        ]
        tasks.append(contentsOf: sampleTasks)
    }
    
    func addTask(_ newTask: Task) {
        tasks.append(newTask)
    }
    
    func binding(for task: Task) -> Binding<Task> {
        guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task")
        }
        return Binding<Task>(
            get: { self.tasks[taskIndex]},
            set: {self.tasks[taskIndex] = $0 }
        )
    }
}


