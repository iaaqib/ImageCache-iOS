//
//  AHImageViewExtenstion.swift
//  ImageCache
//
//  Created by Aaqib Hussain on 09/10/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit

extension  UIImageView {
    
    

    typealias imageDownloadCompletion = (NSError?) -> Void
    
    //Usage :- imageView.downloadImage(url) returns NSError on completion
    //Downloads and Caches images asynchronously. Uses from cache if already downloaded
    //Loads new images only if scrolled inside the list
    
    
    func downloadImage(url: NSURL , completion: imageDownloadCompletion){
        
        if containsImageInCache(url.absoluteString) == false{
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
                data, response, error in
                if error == nil {
                    if let  data = data,
                        image = UIImage(data: data) {
                        AHCache.sharedInstance.setObject(
                            image,
                            forKey: url.absoluteString,
                            cost: data.length)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.image = image
                            completion(nil)
                        }
                    }
                }
                else{
                    if let error = error{
                        completion(error)
                    }
                    
                }
            }
            task.resume()
            
        }
        
    }
    
    private func containsImageInCache(key: String) -> Bool{
        if (AHCache.sharedInstance.objectForKey(key) as? UIImage == nil){
            debugPrint("Not in Cache so download:\(key)")
            return false
            
        }
        debugPrint("In Cache")
        return true
        
    }
    
    
}





