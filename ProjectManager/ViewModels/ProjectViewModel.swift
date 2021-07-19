//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/11/21.
//

import Foundation
import CoreData
import SwiftUI

class ProjectViewModel: ObservableObject {
    
    // MARK: - Private vars/lets
    private let persistenceController = PersistenceController.shared
    private var projectModel: Project
    
    
    // MARK: - Inits
    init() {
        projectModel = Project(context: persistenceController.container.viewContext)
        
        timestamp = Date()
        projectName = ""
        projectDescription = ""
        projectCardColor = Color.random
        
        addTeamMember(name: "Team Leader")
    }
    
    init(project: Project) {
        projectModel = project
    }
    
    
    
    // MARK: - Other Methods
    func save() {
        persistenceController.save()
    }

    func deleteProject() {
        persistenceController.container.viewContext.delete(projectModel)
    }

    func refresh() {
        objectWillChange.send()
        persistenceController.container.viewContext.rollback()
    }
    
    
    
    // MARK: - Getters and Setters
    var id: NSManagedObjectID {
        projectModel.objectID
    }
    
     var timestamp: Date {
        get {
            return projectModel.timestamp!
        }
        set {
            projectModel.timestamp = newValue
        }
    }
    
    var projectName: String {
        get {
            return projectModel.projectName!
        }
        set {
            projectModel.projectName = newValue
        }
    }
    
    var projectDescription: String {
        get {
            return projectModel.projectDescription!
        }
        set {
            projectModel.projectDescription = newValue
        }
    }
    
    var projectCardColor: Color {
        get {
            do {
                return try Color(NSKeyedUnarchiver.unarchivedObject(
                                    ofClass: UIColor.self,
                                    from: projectModel.projectCardColor!)!)
            } catch {
                print(error)
            }
            
            return Color.clear
        }
        set {
            do {
                try projectModel.projectCardColor = NSKeyedArchiver.archivedData(
                    withRootObject: UIColor(newValue),
                    requiringSecureCoding: false)
            } catch {
                print(error)
            }
        }
    }
    
    var teamMembers: [TeamMemberViewModel] {
        get {
            let team = (projectModel.teamMembers?.allObjects as! [TeamMember]).map(TeamMemberViewModel.init)
            return team.sorted{$0.timestamp < $1.timestamp}
        }
    }
    
    func addTeamMember(name: String) {
        let newTeamMember = TeamMemberViewModel()
        
        newTeamMember.timestamp = Date()
        newTeamMember.name = name
        newTeamMember.project = projectModel
    }

    func removeTeamMember(offsets: IndexSet) {
        objectWillChange.send()
        
        offsets.forEach { idx in
            teamMembers[idx].removeTeamMember()
        }
    }
    
}
