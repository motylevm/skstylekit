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
    
    class func color(with colorString: String?) -> UIColor? {
        guard let colorString = colorString else { return nil }
        
        if let result = cache[colorString] {
            return result
        }
        
        if let result = UIColor.sk_Color(from: colorString) {
            
            cache[colorString] = result
            return result
        }
        
        return nil
    }
}
