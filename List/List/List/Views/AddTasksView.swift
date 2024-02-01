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
    let onCancel: () -> Void
    let onAdd: () -> Void
    @Binding var title: String
    @Binding var notes: String
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("TASK TITLE")) {
                    TextField("My new task", text: $title)
                }
                Section(header: Text("NOTES")) {
                    TextField("Notes", text: $notes)
                }
            }
            .navigationBarTitle("Adding New Task", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: onCancel), trailing: Button("Add", action: onAdd))
        }
    }
    
}




