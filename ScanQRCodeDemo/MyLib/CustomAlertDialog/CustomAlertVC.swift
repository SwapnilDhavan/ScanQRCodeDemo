//
//  CustomAlertVC.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import UIKit

class CustomAlertVC: UIViewController {

    @IBOutlet weak var lblMessageContent: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imgResult: UIImageView!
    @IBOutlet weak var viewYes: UIView!
    @IBOutlet weak var viewNo: UIView!
    
    var isBtnNo: Bool = false
    var contentText: String = ""
    var buttonAction: ((Bool)-> Void)?
    var status: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgResult.layer.cornerRadius = imgResult.frame.height/2
        
        if isBtnNo == false{
            viewNo.isHidden = true
            btnYes.setTitle("OK", for: .normal)
        }
        if status == true{
            btnYes.backgroundColor = UIColor(rgb: 0x00b576)
            btnNo.backgroundColor = UIColor(rgb: 0x00b576)
            imgResult.image = UIImage(named: "success")
        }else{
            btnYes.backgroundColor = UIColor(rgb: 0xC1272D)
            btnNo.backgroundColor = UIColor(rgb: 0xC1272D)
            imgResult.image = UIImage(named: "error")
        }
        
        //btnNo.addBorderLeft(size: 0.5, color: UIColor.lightGray)
        
        //uiView.setShadowView()
        lblMessageContent.text! = contentText

        // Do any additional setup after loading the view.
    }
    @IBAction func btnYesTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        buttonAction?(true)
    }
    @IBAction func btnNoTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        buttonAction?(false)
    }
    
}
