//
//  UICollectionView+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import UIKit

extension UICollectionView {

  func scrollToTop(animated: Bool = true) {
    guard contentOffset.y > 0 else { return }
    setContentOffset(.zero, animated: animated) // Scroll to top
  }
}
