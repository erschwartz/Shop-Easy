//
//  ImagePickerController.swift
//  ShopEasy
//
//  Created by Admin on 11/14/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    var first = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func didSelectTakePhoto(sender: AnyObject) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        if (!first) {
            takePhotoButton.setTitle("Retake Photo", forState: UIControlState.Normal)
            first = true
            doneButton.hidden = false
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        pickedImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as? ItemSelectorViewController
        viewController!.setImage = pickedImage.image
    }
}