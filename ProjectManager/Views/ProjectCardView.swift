//
//  ProjectCardView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/4/21.
//

import SwiftUI

struct ProjectCardView: View {
    
    let projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(projectVM.projectName)")
                .font(.headline)
            Spacer()
            HStack {
                Label("numOfTeam", systemImage: "person.3")
                Spacer()
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(projectVM.projectCardColor.accessibleFontColor)
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProjectCardView(projectVM: ProjectListViewModel.getAllItemsForPreview()[0])
            .background(Color.green)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}