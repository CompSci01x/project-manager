//
//  TeamMemberViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/18/21.
//

import Foundation
import CoreData

class TeamMemberViewModel: ObservableObject {
    
    // MARK: - Private vars/lets
    private let persistenceController = PersistenceController.shared
    private var teamMemberModel: TeamMember
    
    
    // MARK: - Inits
    init() {
        teamMemberModel = TeamMember(context: persistenceController.container.viewContext)
        
        teamMemberModel.timestamp = Date()
        teamMemberModel.name = ""
        teamMemberModel.project = nil
        
        let welcomeTask = TaskViewModel()
        welcomeTask.name = "Welcome"
        welcomeTask.taskDescription = "Welcome to the team!"
        addNewTask(taskVM: welcomeTask)
    }
    
    init(teamMember: TeamMember) {
        teamMemberModel = teamMember
    }
    
    
    
    // MARK: - Other Methods
    func save() {
        objectWillChange.send()
        persistenceController.save()
    }
    
    func removeTeamMember() {
        persistenceController.container.viewContext.delete(teamMemberModel)
    }

    func refresh() {
        objectWillChange.send()
        persistenceController.container.viewContext.rollback()
    }
    
    
    // MARK: - Getters and Setters
    var id: NSManagedObjectID {
        teamMemberModel.objectID
    }
    
    var timestamp: Date {
        get {
            return teamMemberModel.timestamp!
        }
        set {
            teamMemberModel.timestamp = newValue
        }
    }
    
    var name: String {
        get {
            return teamMemberModel.name!
        }
        set {
            teamMemberModel.name = newValue
        }
    }
    
    var project: Project? {
        get {
            return teamMemberModel.project
        }
        set {
            teamMemberModel.project = newValue
        }
    }
    
    var tasks: [TaskViewModel] {
        get {
            let tasks = (teamMemberModel.tasks?.allObjects as! [Task]).map(TaskViewModel.init)
            return tasks.sorted{ $0.timestamp > $1.timestamp }
        }
    }
    
    func addNewTask(taskVM: TaskViewModel) {
        
        taskVM.timestamp = Date()
        taskVM.teamMember = teamMemberModel        
    }
    
    func deleteTask(offsets: IndexSet) {
        objectWillChange.send()

        offsets.forEach { idx in
            tasks[idx].deleteTask()
        }
        
        persistenceController.save()
    }
    
}
