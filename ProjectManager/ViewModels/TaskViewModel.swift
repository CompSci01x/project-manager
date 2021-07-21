//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/19/21.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    
    // MARK: - Private vars/lets
    private let persistenceController = PersistenceController.shared
    private var taskModel: Task
    
    // MARK: - Inits
    init() {
        taskModel = Task(context: persistenceController.container.viewContext)

        taskModel.timestamp = Date()
        taskModel.name = ""
        taskModel.taskDescription = ""
        taskModel.teamMember = nil
    }
    
    init(task: Task) {
        taskModel = task
    }
    
    
    // MARK: - Other Methods
    func deleteTask() {
        persistenceController.container.viewContext.delete(taskModel)
    }    
    
    // MARK: - Getters and Setters
    var id: NSManagedObjectID {
        taskModel.objectID
    }
    
    var timestamp: Date {
        get {
            return taskModel.timestamp!
        }
        set {
            taskModel.timestamp = newValue
        }
    }
    
    var name: String {
        get {
            return taskModel.name!
        }
        set {
            taskModel.name = newValue
        }
    }
    
    var taskDescription: String {
        get {
            return taskModel.taskDescription!
        }
        set {
            taskModel.taskDescription = newValue
        }
    }
    
    var teamMember: TeamMember? {
        get {
            return taskModel.teamMember
        }
        set {
            taskModel.teamMember = newValue
        }
    }
}
