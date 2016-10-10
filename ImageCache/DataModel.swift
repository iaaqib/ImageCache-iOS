//
//  DataModel.swift
//  ImageCache
//
//  Created by Aaqib Hussain on 10/10/2016.
//  Copyright © 2016 Kode Snippets. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    
    var providerLogo : String?
    
    
    init(data: NSArray , index : Int){
       
        if let logoUrl = data[index]["provider_logo"] as? String{
        self.providerLogo = logoUrl.stringByReplacingOccurrencesOfString("{size}", withString: "63")
            
        }
        
    }
    


}
