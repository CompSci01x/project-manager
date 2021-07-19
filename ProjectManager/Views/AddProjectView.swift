//
//  AddProjectView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/6/21.
//

import SwiftUI

struct AddProjectView: View {

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var projectListVM: ProjectListViewModel
    @StateObject private var projectVM = ProjectViewModel()
    
    @State private var showingAlert: Bool = false
    @State private var newTeamMemberName: String = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Name")) {
                    TextField("Project Name", text: $projectVM.projectName)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $projectVM.projectDescription)
                        .frame(width: UIScreen.main.bounds.width - 75, height: 150, alignment: .topLeading)
                }

                Section(header: Text("Color")) {
                    ColorPicker("Card Color", selection: $projectVM.projectCardColor)
                }

                Section(header: Text("Team Member(s)")) {
                    
                    ForEach(projectVM.teamMembers, id: \.id) { teamMember in
                        Label(teamMember.name, systemImage: "person")
                    }
                    .onDelete(perform: { indexSet in
                        projectVM.removeTeamMember(offsets: indexSet)
                    })

                    HStack {
                        TextField("New Team Member", text: $newTeamMemberName)
                        Button(action: {
                            withAnimation {
                                projectVM.addTeamMember(name: newTeamMemberName)
                                newTeamMemberName = ""
                            }}) {
                            Image(systemName: "plus.circle")
                        }
                        .disabled(newTeamMemberName.isEmpty)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Add Project")
        .navigationBarItems(leading: Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
            
        }, trailing: Button("Done") {
            
            if (projectVM.projectName.isEmpty) {
                showingAlert = true
            } else {
                projectListVM.addNewProject(projectVM: projectVM)
                presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Project Name Required"), message: Text("Project requires a name."), dismissButton: .default(Text("Ok")))
        }
        
    }
}

struct AddProjectView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            AddProjectView(projectListVM: ProjectListViewModel())
        }
    }
}
