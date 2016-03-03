//
//  CameraViewController.swift
//  Instagramer
//
//  Created by David Wayman on 3/2/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var cameraOverlay: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            //currentImageView.image = editedImage
            
            // SEPIA FILTER EXAMPLE:::::::::::::::::::
            /* http://www.raywenderlich.com/76285/beginning-core-image-swift */
            let beginImage = CIImage(image: editedImage)
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(beginImage, forKey: kCIInputImageKey)
            filter?.setValue(0.5, forKey: kCIInputIntensityKey)
            
            // 1
            let context = CIContext(options:nil)
            
            // 2
            let cgimg = context.createCGImage((filter?.outputImage)!, fromRect: (filter?.outputImage!.extent)!)
            
            // 3
            let newImage = UIImage(CGImage: cgimg)
            self.imageView.image = newImage
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        print("pressed cancel")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPostPic(sender: AnyObject) {
        // Resize image FIRST!!!!!!!
        
        Post.postUserImage(self.imageView.image, caption: "Hello World") { (success: Bool, error: NSError?) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func onTakeAPic(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
