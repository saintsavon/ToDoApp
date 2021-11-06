//
//  ToDoItem.swift
//  ToDo
//
//  Created by Jaylen Scott on 11/5/21.
//

import Foundation

// This is the struct for each ToDo item in the list
struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var important: Bool
    var reminder: Bool
    
    init(title: String, important: Bool, reminder: Bool) {
        self.title = title
        self.important = important
        self.reminder = reminder
    }
    
}

// This is where/how ToDo items are stored
class ToDoStorage: ObservableObject {
    // Published allows us to access this throughout the app
    @Published var toDos = [ToDoItem]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(toDos),
                                       forKey: "toDos")
        }
    }
    
    init() {
        // This checks for stored ToDo items by the user
        if let data = UserDefaults.standard.value(forKey: "toDos") as? Data {
            if let userDefaultTodos = try? PropertyListDecoder().decode(Array<ToDoItem>.self, from: data) {
                toDos = userDefaultTodos
            }
        }
    }
}
