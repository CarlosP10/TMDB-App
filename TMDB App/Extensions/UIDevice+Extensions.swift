//
//  UIDevice+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import UIKit

extension UIDevice {
    /// Check if current device is phone idiom
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
