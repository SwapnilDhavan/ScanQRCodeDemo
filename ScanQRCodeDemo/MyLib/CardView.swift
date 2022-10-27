//
//  CardView.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerradius : CGFloat = 10
    @IBInspectable var shadowOffSetWidth : CGFloat = 1
    @IBInspectable var shadowOffSetHeight : CGFloat = 1
    @IBInspectable var shadowColor : UIColor = UIColor.black
    @IBInspectable var shadowOpacity : CGFloat = 0.3
    
   
    override func layoutSubviews() {
        /*let path =  UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer*/
        layer.cornerRadius = cornerradius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth,height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
