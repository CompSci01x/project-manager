//
//  ProjectCardView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import SwiftUI

struct ProjectCardView: View {
    
    var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(projectVM.projectName)")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            HStack {
                Label("\(projectVM.teamMembers.count)", systemImage: "person.3")
                Spacer()
            }
            .font(.subheadline)
        }
        .padding()
        .foregroundColor(projectVM.projectCardColor.accessibleFontColor)
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProjectCardView(projectVM: ProjectListViewModel.getAllProjectsForPreview()[0])
            .background(Color.random)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
