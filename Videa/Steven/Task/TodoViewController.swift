//
//  TodoViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 29/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var videoLinkTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    
    var apiKey: String = ""
    var task: Task!
    var todoList: [Todo] = []
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        let youtubeUrl = videoLinkTextField.text
        let youtubeId = self.getYoutubeId(youtubeUrl: youtubeUrl!)
        print(youtubeId!)
        
        let videoUrl = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=\(apiKey)&id=\(youtubeId!)&part=snippet,contentDetails,statistics")
        
        var videoDetail: VideoDetail?
        let getVideoTask = URLSession.shared.dataTask(with: videoUrl!) { (data, response, error) in
            do {
                videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            let videoName = videoDetail!.items![0].snippet?.title
            let viewCount = videoDetail!.items![0].statistics?.viewCount
            let likeCount = videoDetail!.items![0].statistics?.likeCount
            let commentCount = videoDetail!.items![0].statistics?.commentCount
            
            if Int(viewCount!)! >= self.todoList[0].targetNumber! {
                DispatchQueue.main.async {
                    self.todoTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                }
            }
            
            if Int(likeCount!)! >= self.todoList[1].targetNumber! {
                DispatchQueue.main.async {
                    self.todoTableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryType = .checkmark
                }
            }
            
            if Int(commentCount!)! >= self.todoList[2].targetNumber! {
                DispatchQueue.main.async {
                    self.todoTableView.cellForRow(at: IndexPath(row: 2, section: 0))?.accessoryType = .checkmark
                }
            }
            
            print("Title:\(videoName)")
            print("View: \(viewCount)")
            print("Like: \(likeCount)")
            print("Comment: \(commentCount)")
            //            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        
        getVideoTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
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
