//
//  SwiftUIView.swift
//  List
//
//  Created by Stevie on 1/23/24.
//

import SwiftUI

struct AddTasksView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var store: Store
    @Binding var title: String
    @Binding var notes: String
    
    func onCancel() {
        self.dismiss()
    }
    
    func addTask() {
        let newTask = Task(title: title, notes: notes, isCompleted: false)
        store.addTask(newTask)
        self.dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("TASK TITLE")) {
                    TextField("My new task", text: $title)
                }
                Section(header: Text("NOTES")) {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .textFieldStyle(.plain)
                        .lineLimit(5, reservesSpace: true)
                }
            }
            .navigationBarTitle("Adding New Task", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: onCancel), trailing: Button("Add", action: addTask)
                .disabled(title.isEmpty))
        }
    }
    
}




