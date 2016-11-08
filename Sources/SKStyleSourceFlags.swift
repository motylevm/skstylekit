//
//  SKStyleSourceFlags.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 02/11/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import Foundation

// UIView bit flags
let viewCommonFlag = 1 << 0
let viewBorderFlag = 1 << 1
let viewColorFlag  = 1 << 2
let viewShadowFlag = 1 << 3
let viewAllFlags = viewCommonFlag | viewBorderFlag | viewColorFlag | viewShadowFlag

// UILabel bit flags
let labelCommonFlag = 1 << 4
let labelAdvancedFlag = 1 << 5
let labelAllFlags = labelCommonFlag | labelAdvancedFlag

// UIControl bit flags
let controllAllFlags = 1 << 6

extension SKStyle {
    
    // MARK: - Getting flags
    func getFlags() -> Int {
        return getViewFlags() | getLabelFlags() | getControlFlags()
    }

    private func getViewFlags() -> Int {
        
        var result = 0
        
        if checkIfContainsViewCommonStyle() {
            result = result | viewCommonFlag
        }
        
        if checkIfContainsViewBorderStyle() {
            result = result | viewBorderFlag
        }
        
        if checkIfContainsViewColorStyle() {
            result = result | viewColorFlag
        }
        
        if checkIfContainsViewShadowStyle() {
            result = result | viewShadowFlag
        }
        
        return result
    }
    
    private func getLabelFlags() -> Int {
        
        var result = 0
        
        if checkIfContainsLabelCommonStyle() {
            result = result | labelCommonFlag
        }
        
        if checkIfContainsLabelAdvancedStyle() {
            result = result | labelAdvancedFlag
        }
        
        return result
    }
    
    private func getControlFlags() -> Int {
        return checkIfContainsControlStyle() ? controllAllFlags : 0
    }
}
