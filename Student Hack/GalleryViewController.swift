//
//  GalleryViewController.swift
//  Student Hack
//
//  Created by Parham on 28/10/2014.
//  Copyright (c) 2014 Parham Majdabadi. All rights reserved.
//

import UIKit

class GalleryViewController: UITableViewController {
    
    var images : [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        self.getImages()
        
    }
    
    // MARK: - Helper methods
    
    func getImages() {
        
        MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        
        let query = PFQuery(className: "Gallery")
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            
            if error == nil {
                
                self.images = result as [PFObject]
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.navigationController?.view, animated: true)
                
            } else {
               println(error.userInfo)
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("galleryCell", forIndexPath: indexPath) as UITableViewCell
        
        if !self.images.isEmpty {
            let galleryItem = self.images[indexPath.row]
            
            let galleryImageView = tableView.viewWithTag(1) as UIImageView
            
            
            if let image = galleryItem["image"] as? PFFile {
                
                image.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    if error == nil {
                        
                        galleryImageView.image = UIImage(data: data);
                        
                    }
                    
                })
                
            }
        }

        return cell
    }

}
