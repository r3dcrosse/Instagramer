//
//  HomeTimelineTableViewCell.swift
//  Instagramer
//
//  Created by David Wayman on 3/4/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTimelineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userCaptionUsername: UILabel!
    @IBOutlet weak var userCaptionTextView: UITextView!
    
    /* OBJECT DESIGNED BY @Monte9 */
    var object: PFObject? {
        didSet {
            post = Post(object: object!)
            post.cell = self;
        }
    }
    
    var post: Post! {
        didSet {
            usernameLabel.text = post.usernameString
            userCaptionUsername.text = post.usernameString
            userImageView.image = post.image
            userCaptionTextView.text = post.caption
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
