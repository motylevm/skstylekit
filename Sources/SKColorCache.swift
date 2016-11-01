//
//  SKColorCache.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 01/11/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import UIKit

private var cache = [String: UIColor]()

class SKColorCache {
    
    class func color(with hexString: String?) -> UIColor? {
        guard let hexString = hexString else { return nil }
        
        if let result = cache[hexString] {
            return result
        }
        
        if let result = UIColor.sk_Color(fromHexString: hexString) {
            
            cache[hexString] = result
            return result
        }
        
        return nil
    }
}
