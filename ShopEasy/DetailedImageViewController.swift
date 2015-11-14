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
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
}