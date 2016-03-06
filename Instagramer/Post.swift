//
//  Post.swift
//  Instagramer
//
//  Created by David Wayman on 3/3/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit
import Parse

/* CLASS MODEL DESIGNED BY @Monte9 */
let imageDataSetNotification = "imageDataSet";

class Post: NSObject {
    
    var username: PFUser?
    var usernameString: String?
    var caption: String?
    var image: UIImage?
    var numLikes: Int?
    var numComments: Int?
    
    var cell: HomeTimelineTableViewCell?
    
    init(object: PFObject) {
        
        super.init()
        
        // Create Parse object PFObject
        let newObject = object
        
        print("Get details of photo from object")
        // Add relevant fields to the object
        username = newObject["author"] as? PFUser
        caption = newObject["caption"] as? String
        numLikes = newObject["likesCount"] as? Int
        numComments = newObject["commentsCount"] as? Int
        
        usernameString = username?.username!
        
        if let newImage = object.valueForKey("media")! as? PFFile {
            
            newImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    print("Image data found.. saving UIImage")
                    let image = UIImage(data: imageData!)
                    print(image)
                    self.image = image
                    self.cell?.post = self;
                    NSNotificationCenter.defaultCenter().postNotificationName(imageDataSetNotification, object: nil)
                } else {
                    print("ERROR: could not get image \(error?.localizedDescription)")
                }
                }, progressBlock: { (int: Int32) -> Void in
                    print("int yay!")
            })
        }
    }

     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    /**
     Method to resize image
    */
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
