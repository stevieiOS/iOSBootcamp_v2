//
//  TaskDetailView.swift
//  List
//
//  Created by Stevie on 1/24/24.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment (\.dismiss) var dismiss
    @Binding var task: Task
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $task.title)
                }
                Section(header: Text("Notes")) {
                    TextField("Notes", text: $task.notes)
                }
                Section(header: Text("Status")) {
                    Toggle("Completed", isOn: $task.isCompleted)
                }
            }
        }
    }
}

