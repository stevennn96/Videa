//
//  TodoViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 29/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var task: Task!
    var todoList: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        todoList = (task?.todoList)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoTableViewCell
        
        cell.setTodo(todo: todo)
        return cell
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
