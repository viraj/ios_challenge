//
//  UIView+Extension.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit

 extension UIView {

    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
 }
