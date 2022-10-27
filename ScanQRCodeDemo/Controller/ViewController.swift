//
//  ViewController.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var qrImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.title = "Scan QR Code Demo"
    }

    @IBAction func btnScanQRAnim1Tap(_ sender: Any) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let desController = mainStoryBoard.instantiateViewController(withIdentifier: "QrcodeScannerVC") as! QrcodeScannerVC
        desController.anim_type = Constants.shared.ANIM_TYPE_ONE
        self.navigationController?.pushViewController(desController, animated: true)
    }
    
    @IBAction func btnScanQRAnim2Tap(_ sender: Any) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let desController = mainStoryBoard.instantiateViewController(withIdentifier: "QrcodeScannerVC") as! QrcodeScannerVC
        desController.anim_type = Constants.shared.ANIM_TYPE_TWO
        self.navigationController?.pushViewController(desController, animated: true)
    }
    
    @IBAction func btnScanQRGalleryQRImageTap(_ sender: Any) {
        ImagePicker.shared.PickImage(viewContoller: self, imageView: qrImageView, completion: {(Success) in
            self.getDataFromQRCodeImage()
        })
    }
    
    //this func user for get data from qrcode Image
    func getDataFromQRCodeImage(){
        let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        let ciImage: CIImage = CIImage(image:qrImageView.image!)!
        var qrCodeData = ""
        
        let features = detector.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            qrCodeData += feature.messageString!
        }
        
        if qrCodeData=="" {
            print("Something went wrong")
            DispatchQueue.main.async {
                self.AlertDialog(msg: "Something went wrong", isBtnNo: false, status: false, completion: {_ in })
            }
        }else{
            print("message: \(qrCodeData)")
            DispatchQueue.main.async {
                self.AlertDialog(msg: qrCodeData, isBtnNo: false, status: true, completion: {_ in })
            }
        }
    }
}

