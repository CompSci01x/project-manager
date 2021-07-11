//
//  ProjectCardView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import SwiftUI

struct ProjectCardView: View {
    
    let project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(project.projectName!)")
                .font(.headline)
            Spacer()
            HStack {
                Label("numOfTeam", systemImage: "person.3")
                Spacer()
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(project.getColor().accessibleFontColor)
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProjectCardView(project: ProjectListViewModel.getAllItemsForPreview()[0])
            .background(Color.green)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
