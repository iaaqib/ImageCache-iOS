//
//  AHNSURLExtension.swift
//  ImageCache
//
//  Created by Aaqib Hussain on 09/10/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit

extension NSURL {
    
    typealias dataFinishedDownloading = (AnyObject?, NSURLResponse? , NSError?) -> Void
    //Usage:- NSURL(url).fetchData
    //Downloads and Auto Cache JSON
    func fetchData(completion: dataFinishedDownloading){
        
        
        
        
        
        
        let task =  NSURLSession.sharedSession().dataTaskWithURL(self) { (data, response, error) in
            
            
            
            
            if  error == nil{
                if let fetchedData = data{
                    
                    do {
                        //If array run this
                        if  let jsonArray = try  NSJSONSerialization.JSONObjectWithData(fetchedData, options: .MutableContainers) as? NSArray{
                            //Cache array
                            AHCache.sharedInstance.setObject(
                                jsonArray,
                                forKey: self.absoluteString,
                                cost: fetchedData.length)
                            return  completion(jsonArray, response, nil)
                            
                            
                        }
                        //if dictionary run this
                        if  let jsonObject = try  NSJSONSerialization.JSONObjectWithData(fetchedData, options: .MutableContainers) as? NSDictionary{
                           //Cache Dictionary
                            AHCache.sharedInstance.setObject(
                                jsonObject,
                                forKey: self.absoluteString,
                                cost: fetchedData.length)
                            return  completion(jsonObject, response, nil)
                            
                        }
                        
                        
                    }
                    catch let error as NSError {
                        print(error.localizedDescription)
                        return  completion(nil, response, error)
                        
                    }
                    
                    
                }
                
                
            }
            else{
                
                
                return  completion(nil,response,error)
            }
            
        }
        task.resume()
        
    }
    
    
    
    
}




