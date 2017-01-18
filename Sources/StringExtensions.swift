//
//  StringExtensions.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 17/01/2017.
//  Copyright © 2017 mmotylev. All rights reserved.
//

import Foundation

extension String {
    
    func sk_substring(with range: NSRange) -> String? {
        guard range.length > 0 else { return "" }
        
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        
        guard start < end else { return nil }
        
        return substring(with: start ..< end)
    }
}
