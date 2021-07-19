//
//  ProjectDetailView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/10/21.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @ObservedObject var projectVM: ProjectViewModel
    @State private var isPresented = false
    
    var body: some View {
        
        List {
            
            Section(header: Text("Description")) {
                ScrollView {
                    Text(projectVM.projectDescription)
                        .frame(width: UIScreen.main.bounds.size.width - 75, height: 150, alignment: .topLeading)
                }
            }
            
            Section(header: Text("Color")) {
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(projectVM.projectCardColor)
                }
            }
            
            Section(header: Text("Team Members")) {
                ForEach(projectVM.teamMembers, id:\.id) { teamMember in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Label(teamMember.name, systemImage: "person")
                        })
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(projectVM.projectName)
        .navigationBarItems(trailing: Button("Edit") { isPresented.toggle() })
        .fullScreenCover(isPresented: $isPresented,
                         onDismiss: { projectVM.refresh() },
                         content: {
                            NavigationView {
                                EditProjectView(projectVM: projectVM)
                            }
        })
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    
    static let previewProjects = ProjectListViewModel.getAllProjectsForPreview()
    static var previews: some View {
        NavigationView {
            ProjectDetailView(projectVM: previewProjects[0])
        }
    }
}
