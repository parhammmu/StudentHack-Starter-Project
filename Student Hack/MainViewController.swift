//
//  MainViewController.swift
//  Student Hack
//
//  Created by Parham on 27/10/2014.
//  Copyright (c) 2014 Parham Majdabadi. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var galleryButton : UIButton! {
        didSet {
            self.galleryButton.addTarget(self, action: "galleryButtonTapped", forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 250;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.getConfigObject()

    }
    
    // MARK: TableView delegate methods
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, self.tableView.frame.width, 50))
        footerView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5);
        
        // Create and set Gallery Button
        self.galleryButton = UIButton(frame: CGRectMake(0, 0, footerView.frame.width, 50))
        galleryButton.backgroundColor = UIColor.redColor()
        galleryButton.setTitle("Gallery", forState: .Normal)
        galleryButton.tintColor = UIColor.blueColor()
        footerView.addSubview(galleryButton)
        
        return footerView;

        
    }
    
    // MARK: Helper methods
    
    func getConfigObject() {
        
        MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        
        PFConfig.getConfigInBackgroundWithBlock { (config, error) -> Void in
            
            if error == nil {
                
                let title = config["title"] as String
                let intro = config["intro"] as String
                let logo = config["logo"] as PFFile
                
                // Get the logo from cloud
                logo.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    if error == nil {
                        
                        self.logoImageView.image = UIImage(data: data)
                        
                    }
                    
                })
                
                self.titleLabel.text = title
                self.descriptionLabel.text = intro
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.navigationController?.view, animated: true)
                
            }
            
        }
        
    }
    
    func galleryButtonTapped() {
        self.performSegueWithIdentifier("gallerySegue", sender: self)
    }


}
