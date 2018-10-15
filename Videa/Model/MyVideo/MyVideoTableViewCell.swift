//
//  MyVideoTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 13/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class MyVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var myVideoImageView: UIImageView!
    @IBOutlet weak var myVideoTitleLabel: UILabel!
    @IBOutlet weak var myVideoViewLabel: UILabel!
    @IBOutlet weak var myVideoCommentLabel: UILabel!
    @IBOutlet weak var myVideoLikeLabel: UILabel!
    @IBOutlet weak var myVideoDislikeLabel: UILabel!
    
    func setMyVideo(myVideo: MyVideo) {
        myVideoImageView.downloaded(from: myVideo.imageUrl!)
        myVideoTitleLabel.text = myVideo.title
        myVideoViewLabel.text = myVideo.viewCount
        myVideoCommentLabel.text = myVideo.commentCount
        myVideoLikeLabel.text = myVideo.likeCount
        myVideoDislikeLabel.text = myVideo.dislikeCount
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
