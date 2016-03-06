//
//  CaptionViewController.swift
//  Instagramer
//
//  Created by David Wayman on 3/5/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionBox: UITextView!
    
    var caption: String = ""
    var theImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = theImage
        captionBox.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostPic(sender: AnyObject) {
        let image = Post.resize(theImage, newSize: CGSize(width: 400, height: 400))
        
        caption = captionBox.text! ?? ""
        
        Post.postUserImage(image, caption: caption) { (success: Bool, error: NSError?) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
