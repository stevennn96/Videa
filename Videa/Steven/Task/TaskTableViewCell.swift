//
//  TaskTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var taskProgressView: UIProgressView!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskProgressLabel: UILabel!
    
    var todoList: [Todo] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskProgressView.transform = taskProgressView.transform.scaledBy(x: 1, y: 3)
        taskProgressView.progressTintColor = UIColor.orange
        taskView.layer.cornerRadius = 5
        // Initialization code
    }

    func setTaskDetail(task: Task) {
        taskNameLabel.text = task.taskName
        taskProgressLabel.text = "\(task.taskDone!) of \(task.taskReq!) Tasks Finished"
        taskProgressView.progress = Float(task.taskDone!)/Float(task.taskReq!)
        todoList = task.todoList
    }

}
