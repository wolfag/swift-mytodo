 //
//  CoreDataManager.swift
//  MyTodo
//
//  Created by wolfag on 19/12/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistenContainer = NSPersistentContainer(name: "TaskModel")
        persistenContainer.loadPersistentStores { des, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
