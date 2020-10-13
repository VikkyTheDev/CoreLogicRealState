//
//  Banner.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 27/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import Foundation
import NotificationBannerSwift
class Banner{
    class func show(_ message: String?, duration: TimeInterval = 2.0){
        guard let message = message else{return}
        let banner = GrowingNotificationBanner(title: message, subtitle: "", style: .success)
        banner.duration = duration
        banner.show()
    }
}
