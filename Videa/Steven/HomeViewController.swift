//
//  HomeViewController.swift
//  test
//
//  Created by Sia Feri Santos on 22/08/18.
//  Copyright © 2018 Sia Feri Santos. All rights reserved.
//

import UIKit

var tasks: [Task] = []

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var selectedTask: Task!
    
    @IBAction func addChallenge(_ sender: Any) {
        performSegue(withIdentifier: "goToChallenges", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TodoViewController {
            destination.task = selectedTask
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tasks.count)
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        cell.setTaskDetail(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        print(index)
        selectedTask = tasks[index]
        performSegue(withIdentifier: "HomeToTodo", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
