//
//  MyTodoApp.swift
//  MyTodo
//
//  Created by wolfag on 19/12/2022.
//

import SwiftUI

@main
struct MyTodoApp: App {
    
    let persistenContainer = CoreDataManager.shared.persistenContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenContainer.viewContext)
        }
    }
}
