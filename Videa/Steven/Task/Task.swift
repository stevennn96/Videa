//
//  Task.swift
//  Videa
//
//  Created by Kensen Tjoa on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class Task{
    
    var taskName: String?
    var taskDone: Int?
    var taskReq: Int?
    var todoList: [Todo]
    
    init(taskName: String, taskDone: Int, taskReq: Int, todoList: [Todo]) {
        self.taskName = taskName
        self.taskDone = taskDone
        self.taskReq = taskReq
        self.todoList = todoList
    }
}

class Todo {
    
    var description: String?
    var targetNumber: Int?
    
    init(description: String, targetNumber: Int) {
        self.description = description
        self.targetNumber = targetNumber
    }
}
