//
//  ContentView.swift
//  MyTodo
//
//  Created by wolfag on 19/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State var title: String = ""
    @State var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: true)]) private var allTasks: FetchedResults<Task>

    private func storeToDB() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func saveTask() {
        let task = Task(context: viewContext)
        task.title = title
        task.priority = selectedPriority.rawValue
        task.isDone = false
        task.createdAt = Date()
        
        title = ""

        storeToDB()
    }

    private func doneTask(_ task: Task) {
        task.isDone = !task.isDone

        storeToDB()
    }

    private func deleteTask(at offsets: IndexSet) {
        print(offsets)
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)

            storeToDB()
        }
    }

    private func colorTask(_ val: String) -> Color {
        let priority = Priority(rawValue: val)

        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        default:
            return .black
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)

                Picker("Priority", selection: $selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.title).tag(priority)
                    }
                }.pickerStyle(.segmented)

                Button {
                    saveTask()
                } label: {
                    Text("Save")
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                List {
                    ForEach(allTasks) { task in
                        TaskRow(
                            color: colorTask(task.priority ?? ""),
                            isDone: task.isDone,
                            title: task.title ?? "") {
                            doneTask(task)
                        }
                    }.onDelete(perform: deleteTask)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("All tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistenContainer
        ContentView().environment(\.managedObjectContext, persistedContainer.viewContext)
//        ContentView()
    }
}
