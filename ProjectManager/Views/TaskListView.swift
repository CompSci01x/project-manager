//
//  TaskListView.swift
//  ProjectManager
//
//  Created by Spruce Tree on 7/19/21.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var teamMemberVM: TeamMemberViewModel
    @State private var isPresented = false
    
    var body: some View {
        List {
            ForEach(teamMemberVM.tasks, id:\.id) { task in
                TaskCardView(taskVM: task)
            }
            .onDelete(perform: { indexSet in
                teamMemberVM.deleteTask(offsets: indexSet)
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: Button(action: { isPresented.toggle() }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented,
               content: {
                NavigationView {
                    AddTaskView(teamMemberVM: teamMemberVM)
                }
                .onDisappear(perform: {
                    teamMemberVM.refresh()
                })
        })

    }
}

struct TaskListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            TaskListView(teamMemberVM: TeamMemberViewModel())
        }
    }
}
