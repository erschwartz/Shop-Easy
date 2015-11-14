//
//  ItemSelectorViewController.swift
//  ShopEasy
//
//  Created by Admin on 11/14/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class ItemSelectorViewController: UIViewController {
    
    var rectangleArray = Array<ShapeView>()
    @IBOutlet weak var initialImage: UIImageView!
    var setImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpImage()
        let size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 91)
        initialImage.image = imageWithImage(initialImage.image!, newSize: size)
        let tapGR = UITapGestureRecognizer(target: self, action: "didTap:")
        self.view.addGestureRecognizer(tapGR)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpImage() {
        initialImage.image = setImage
    }
    
    func didTap(tapGR: UITapGestureRecognizer) {
        let tapPoint = tapGR.locationInView(self.view)
        let shapeView = ShapeView(origin: tapPoint)
        self.view.addSubview(shapeView)
        print(tapPoint)
        rectangleArray.append(shapeView)
    }
    
    func imageWithImage(img: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        img.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func getCroppedImage(img: UIImage) -> UIImage {
        let frame = rectangleArray[0].frame
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        let drawRect = CGRectMake(-frame.origin.x, -frame.origin.y, img.size.width, img.size.height)
        CGContextClipToRect(context, CGRectMake(0, 0, frame.size.width, frame.size.height))
        img.drawInRect(drawRect)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! DetailedImageViewController
        vc.detailImage = getCroppedImage(initialImage.image!)
    }
    
    
}