//
//  Notifications.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 09/11/2016.
//  Copyright © 2016 mmotylev. All rights reserved.
//

import Foundation

public let StyleKitDidLoadStylesNotification = "SKStyleKit.DidLoad"

extension Notification.Name {
    public static let SKStyleKitDidLoadStyles = Notification.Name(StyleKitDidLoadStylesNotification)
}
