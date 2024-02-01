//
//  ContentView.swift
//  List
//
//  Created by Stevie on 1/23/24.
//

import SwiftUI

struct ListView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var store = Store()
    @State private var showAddTasksView = false
    @State private var title = ""
    @State private var notes = ""
    
    func addTask() {
        let newTask = Task(title: title, notes: notes, isCompleted: false)
        store.addTask(newTask)
        showAddTasksView = false
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomLeading) {
                MainListView(store: store, title: $title, notes: $notes)
                NewTaskButtonView(showAddTasksView: $showAddTasksView)
            }
            .sheet(isPresented: $showAddTasksView) {
                AddTasksView(store: store, onCancel: {
                    showAddTasksView = false
                }, onAdd: {
                    addTask()
                    dismiss()
                }, title: $title, notes: $notes
                )
            }
        }
        .navigationTitle("Adding a New Task")
    }
}

#Preview {
    ListView()
}

struct MainListView: View {
    @ObservedObject var store: Store
    @Binding var title: String
    @Binding var notes: String
    
    var body: some View {
        List {
            ForEach(store.tasks, id: \.id) { currentTask in
                NavigationLink(destination: TaskDetailView(task: store.binding(for: currentTask))) {
                    HStack {
                        VStack {
                            Text(currentTask.title)
                                .font(.headline.bold())
                            Text(currentTask.notes)
                        }
                        .padding()
                        .font(.subheadline.monospaced())
                        Spacer()
                        Image(systemName: currentTask.isCompleted ? "checkmark.square" : "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(currentTask.isCompleted ? .green : .red)
                    }
                    
                }
                
            }
        }
        
        .navigationTitle("My Tasks")
        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        
        // (.inline) in superior
    }
}


struct NewTaskButtonView: View {
    @Binding var showAddTasksView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                showAddTasksView.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("New Task")
                    .font(.headline.bold())
            }
            .padding()
        }
    }
}



