//
//  ShowCachedImageViewController.swift
//  ImageCache
//
//  Created by Aaqib Hussain on 09/10/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit

class ShowCachedImageViewController: UIViewController {
    
    var getImageUrl : String?
    
    @IBOutlet weak var cachedImage: UIImageView!
    override func viewDidLoad() {
        
        if let key = getImageUrl{
            if let cacheImg = AHCache.sharedInstance.objectForKey(key) as? UIImage{
                self.cachedImage.image = cacheImg
                print("Loaded from Cache")
            }
        }
        
    
    
        
    }
    
    
}
