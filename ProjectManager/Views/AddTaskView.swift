//
//  AddTaskView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/19/21.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var teamMemberVM: TeamMemberViewModel
    @StateObject private var taskVM = TaskViewModel()
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("Task Name", text: $taskVM.name)
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $taskVM.taskDescription)
                    .frame(width: UIScreen.main.bounds.width - 75, height: 150, alignment: .topLeading)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Add Task"))
        .navigationBarItems(leading: Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
            
        }, trailing: Button("Done") {
            
            if taskVM.name.isEmpty {
                showingAlert = true
            } else {
                teamMemberVM.addNewTask(taskVM: taskVM)
                teamMemberVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(isPresented: $showingAlert,
               content: {
                Alert(title: Text("Task Name Required"), message: Text("Task requires a name."), dismissButton: .default(Text("Ok")))
        })
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskView(teamMemberVM: TeamMemberViewModel())
        }
    }
}
