//
//  ChallengeViewController.swift
//  Videa
//
//  Created by Steven - on 20/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let challenges = ["Introduction", "Music", "Comedy", "Food", "How To"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (challenges.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChallengeTableViewCell
        
            cell.myImage.image = UIImage(named: (challenges[indexPath.row] + ".jpg"))
            cell.myLabel.text = challenges[indexPath.row]
        
            return (cell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let mainSB = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdenti <#type#>fier: <#T##String#>)
        
    
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
