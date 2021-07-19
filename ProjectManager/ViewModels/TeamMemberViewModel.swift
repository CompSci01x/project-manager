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
    }
    
    init(teamMember: TeamMember) {
        teamMemberModel = teamMember
    }
    
    
    
    // MARK: - Other Methods
    func removeTeamMember() {
        persistenceController.container.viewContext.delete(teamMemberModel)
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
    
}
