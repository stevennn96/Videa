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
    var videoLink: String?
    
    init(taskName: String, taskDone: Int, taskReq: Int, todoList: [Todo], videoLink: String) {
        self.taskName = taskName
        self.taskDone = taskDone
        self.taskReq = taskReq
        self.todoList = todoList
        self.videoLink = videoLink
    }
}

class Todo {
    
    var description: String?
    var targetNumber: Int?
    var completed: String?
    
    init(description: String, targetNumber: Int, completed: String) {
        self.description = description
        self.targetNumber = targetNumber
        self.completed = completed
    }
}
