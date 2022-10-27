//
//  Constants.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import Foundation
import UIKit

struct Constants {
    
    static let shared = Constants()
    
    var ANIM_TYPE_ONE = 1
    var ANIM_TYPE_TWO = 2
   
    func timeConvert(time: Int) -> String {
        // Log.d("my_tag", "timeConvert:123 " + time / 60 % 24 + " " + time + " " + time / 60);
        // Log.d("my_tag", "timeConvert123: " + time);
        var t: String = "";
        var day: Int!, hour: Int!, minute: Int!;
        day = time / 3600;
        hour = (time % 3600) / 60;
        minute = (time % 3600) % 60;
        
        if (day > 0) {
            if (day < 2){
                t = String(day) + " Day ";}
            else {t = String(day) + " Days ";}
        }
        
        if (hour > 0)
        {t = t + String(hour) + " hr ";}
        
        /*   if (hour < 2)
         t = t + hour + " Hour ";
         else
         t = t + hour + " Hours ";*/
        
        if (minute > 0)
        {t = t + String(minute) + " min";}
        /* if (minute < 2)
         t = t + minute + " Minute";
         else
         t = t + minute + " Minutes";*/
        
        return t;
    }
    //Image function
    func image(_ originalImage:UIImage, scaledToSize:CGSize) -> UIImage {
        if originalImage.size.equalTo(scaledToSize) {
            return originalImage
        }
        UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
        originalImage.draw(in: CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

