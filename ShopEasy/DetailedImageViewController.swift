//
//  DetailedImageViewController.swift
//  ShopEasy
//
//  Created by Admin on 11/14/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import Foundation
import UIKit

class DetailedImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var detailImagesTableView: UITableView!
    var detailImages = Array<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func blah(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailTableViewCell", forIndexPath: indexPath) as! DetailImageTableViewCell
        cell.detailImageView.image = detailImages[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailImages.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}