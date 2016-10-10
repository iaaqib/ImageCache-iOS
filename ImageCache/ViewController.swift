//
//  ViewController.swift
//  ImageCache
//
//  Created by Aaqib Hussain on 09/10/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var imagesUrl : Array<DataModel> = Array<DataModel>()
    
    let url = "https://api.myjson.com/bins/37yzm"
    @IBOutlet var tableView: UITableView!
    
    var selectedImage : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //Sending network request
       NSURL(string: url)?.fetchData({ (data, reponse, error) in
        
        if (error == nil){
            if let containsImages = data{
                
        for i in 0  ..< containsImages.count{
           
            
           self.imagesUrl.append(DataModel(data: containsImages as! NSArray, index: i))
            }
                dispatch_async(dispatch_get_main_queue()) {
                   self.tableView.reloadData()
                }
                
            }
   

        }
        
       })
        
        
        
        
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        AHCache.clearCache()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.imagesUrl.count
   
    
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        if   let url = NSURL(string: imagesUrl[indexPath.row].providerLogo!){

            cell.displayImage.downloadImage(url) { (error) in
               
        }
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedImage = self.imagesUrl[indexPath.row].providerLogo
        
        self.performSegueWithIdentifier("show", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show"{
        let destination = segue.destinationViewController as! ShowCachedImageViewController
            destination.getImageUrl = self.selectedImage
            
        
        }
    }
    @IBAction func emptyTrash(sender: UIBarButtonItem) {
        
        //Remove Cache
        AHCache.clearCache()
        
        
    }
    
    
    @IBAction func refreshTable(sender: UIBarButtonItem) {
        self.tableView.reloadData()
    }
    
    
    
}

