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
import SwiftyJSON
import Alamofire

class ItemSelectorViewController: UIViewController {
    
    var rectangleArray = Array<ShapeView>()
    @IBOutlet weak var initialImage: UIImageView!
    var setImage: UIImage?
    var urlRequestArray = Array<NSMutableURLRequest>()
    
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
    
    func getCroppedImage(img: UIImage, index: Int) -> UIImage {
        let frame = rectangleArray[index].frame
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        let drawRect = CGRectMake(-frame.origin.x, -frame.origin.y, img.size.width, img.size.height)
        CGContextClipToRect(context, CGRectMake(0, 0, frame.size.width, frame.size.height))
        img.drawInRect(drawRect)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        sendToServerRequest(index, img: img)
        return croppedImage
    }
    
    func sendToServerRequest(index: Int, img: UIImage) {
        let url = NSURL(string: "http://shopeasy.herokuapp.com/items")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let imageData = UIImageJPEGRepresentation(img, 0.9)
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: (0))) // encode the image
        let params = ["encoded_data": "yum"]
        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
            print(request.HTTPBody)
        } catch {
            print("error")
        }
        
        urlRequestArray.append(request)
    }
    
    func sendRequests() {
        for (var i = 0; i < urlRequestArray.count; i++) {
            NSURLConnection.sendAsynchronousRequest(urlRequestArray[i], queue: NSOperationQueue.mainQueue(), completionHandler: {(response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            })
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! DetailedImageViewController
        for (var i = 0; i < rectangleArray.count; i++) {
            vc.detailImages.append(getCroppedImage(initialImage.image!, index: i))
        }
                sendRequests()
    }
    
    
}