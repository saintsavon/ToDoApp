//
//  ContentView.swift
//  ToDo
//
//  Created by Jaylen Scott on 11/4/21.
//

import SwiftUI
import UserNotifications // Do I actually need this?

struct ToDoList: View {
    
    @State var isChecked:Bool = false
    @EnvironmentObject var toDoStorage: ToDoStorage
    
    func checked(){
        isChecked = !isChecked
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(self.toDoStorage.toDos) {
                    todo in
                    
                    if todo.important {
                        Button(action: checked) {
                            HStack {
                                Image(systemName: isChecked ? "checkmark.square": "square")
                                Text(todo.title)
                                Spacer()
                                Image(systemName: "exclamationmark").padding(.trailing, 5)
                            }
                        }
                        
                    } else {
                        Button(action: checked) {
                            HStack {
                                Image(systemName: isChecked ? "checkmark.square": "square")
                                Text(todo.title)
                            }
                        }
                        
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
                Image(systemName: "plus").resizable()
                    .aspectRatio(1, contentMode: .fill)
            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList().environmentObject(ToDoStorage())
    }
}
