//
//  ContentView.swift
//  ToDo
//
//  Created by Jaylen Scott on 11/4/21.
//

import SwiftUI

struct ToDoList: View {
    
    @EnvironmentObject var toDoStorage: ToDoStorage
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(self.toDoStorage.toDos) {
                    todo in
                    
                    if todo.important {
                        Text(todo.title).bold().foregroundColor(.white)
                            .padding(4)
                            .background(Rectangle().foregroundColor(.red))
                            .cornerRadius(5)
                        
                    } else {
                        Text(todo.title)
                        
                    }
                    
                }
                // This allows you to delete items from list
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        self.toDoStorage.toDos.remove(at: index)
                    }
                })
                
            }.navigationBarTitle("To Do List")
            .navigationBarItems(trailing: NavigationLink(
                destination: CreateToDo()) {
                Text("Add")
            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList().environmentObject(ToDoStorage())
    }
}
