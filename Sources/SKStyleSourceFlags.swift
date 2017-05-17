//
//  SKStyleSourceFlags.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 02/11/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import Foundation

// UIView bit flags
let flagViewCommon       = 1 << 0
let flagViewBorder       = 1 << 1
let flagViewColor        = 1 << 2
let flagViewShadow       = 1 << 3
let flagViewAny          = flagViewCommon | flagViewBorder | flagViewColor | flagViewShadow
let flagViewWasSet       = 1 << 4

// UIControl bit flags
let flagControllAny      = 1 << 5
let flagControllWasSet   = 1 << 6

// UILabel bit flags
let flagLabelCommon      = 1 << 7
let flagLabelAdvanced    = 1 << 8
let flagLabelAny         = flagLabelCommon | flagLabelAdvanced
let flagLabelWasSet      = 1 << 9


extension SKStyle {
    
    // MARK: - Getting flags
    @inline(__always)
    func checkFlag(_ flag: Int) -> Bool {
        return flags & flag != 0
    }
    
    @inline(__always)
    func setFlag(_ flag: Int) {
        flags = flags | flag
    }
}
