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
    
    var body: some View {
        NavigationView {
            VStack {
                MainListView(store: store, title: $title, notes: $notes)
                Spacer()
                NewTaskButtonView(showAddTasksView: $showAddTasksView)
                    .padding()
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGray6))
            .sheet(isPresented: $showAddTasksView) {
                AddTasksView(store: store, title: $title, notes: $notes)
            }
        }
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
                        .font(.subheadline.italic())
                        Spacer()
                        Image(systemName: currentTask.isCompleted ? "checkmark.square" : "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(currentTask.isCompleted ? .green : .red)
                    }
                }
            }
        }
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
            .background(Color.teal)
            .foregroundColor(.white)
            .clipShape(.capsule)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3) // Add a more realistic shadow
        }
    }
}



