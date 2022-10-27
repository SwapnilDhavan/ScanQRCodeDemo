//
//  QrcodeScannerVC.swift
//  ScanQRCodeDemo
//
//  Created by Swapnil Dhavan on 27/10/22.
//

import UIKit
import AVFoundation

class QrcodeScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var qrCodeFrameView: UIView!
    @IBOutlet weak var btnFlashOnOff: UIButton!
    
    var video = AVCaptureVideoPreviewLayer()
    var deligate_id = String()
    var isScanned = false
    var qrCodeView:UIView!
    
    var anim_type = Constants.shared.ANIM_TYPE_ONE
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Scan QR Code"

        // Do any additional setup after loading the view.
        
        //Creating session
        let session = AVCaptureSession()
        
        //Define capture device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }catch{
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        view.addSubview(qrCodeFrameView)
        
        qrCodeView = UIView()
        
        if let qrCodeView = qrCodeView {
            if anim_type == Constants.shared.ANIM_TYPE_ONE{
                qrCodeView.layer.borderColor = UIColor.green.cgColor
                qrCodeView.layer.borderWidth = 2
            }
            view.addSubview(qrCodeView)
            view.bringSubviewToFront(qrCodeView)
        }
        
        session.startRunning()
        
        if anim_type == Constants.shared.ANIM_TYPE_TWO{
            createScanningIndicator()
            createScanningFrame()
        }
    }
    
    @IBAction func btnFlashOnOffTap(_ sender: Any) {
        toggleFlash()
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
                btnFlashOnOff.setImage(UIImage(named: "flashOn"), for: .normal)
                
            } else {
                btnFlashOnOff.setImage(UIImage(named: "flashOff"), for: .normal)
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            qrCodeView?.frame = CGRect.zero
            return
        }else if isScanned{
            return
        }
        
        
        for metadata in metadataObjects {
            let metadataObj = metadata as! AVMetadataMachineReadableCodeObject
            let code = metadataObj.stringValue
            
            if anim_type == Constants.shared.ANIM_TYPE_ONE{
                let barCodeObject = video.transformedMetadataObject(for: metadataObj)
                qrCodeView?.frame = barCodeObject!.bounds
            }
            
            if metadataObj.type == AVMetadataObject.ObjectType.qr
            {
                //print("Data: ",code)
                //sendScanResult(ScannedText: code!)
                self.AlertDialog(msg: code!, isBtnNo: false, status: true, completion: {_ in
                    self.navigationController?.popViewController(animated: true)
                    return
                })
                return
               
            }
        }
    }
    
   /* func captureOutput(_ output: AVCaptureOutput!, didOutput metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        print("Abcdefghijklmno")
        
        if metadataObjects != nil && metadataObjects.count != nil{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: {(nil)
                        in UIPasteboard.general.string = object.stringValue
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }*/
    
    func createScanningIndicator() {
        
        let height: CGFloat = 15
        let opacity: Float = 0.4
        let topColor = UIColor.green.withAlphaComponent(0)
        let bottomColor = UIColor.green

        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        
        let squareWidth = view.frame.width * 0.6
        let xOffset = view.frame.width * 0.2
        let yOffset = view.frame.midY - (squareWidth / 2)
        layer.frame = CGRect(x: xOffset, y: yOffset, width: squareWidth, height: height)
        
        self.qrCodeView.layer.insertSublayer(layer, at: 0)

        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + squareWidth - height
        let duration: CFTimeInterval = 2

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        layer.add(animation, forKey: nil)
    }
    
    func createScanningFrame() {
                
        let lineLength: CGFloat = 15
        let squareWidth = view.frame.width * 0.6
        let topLeftPosX = view.frame.width * 0.2
        let topLeftPosY = view.frame.midY - (squareWidth / 2)
        let btmLeftPosY = view.frame.midY + (squareWidth / 2)
        let btmRightPosX = view.frame.midX + (squareWidth / 2)
        let topRightPosX = view.frame.width * 0.8
        
        let path = UIBezierPath()
        
        //top left
        path.move(to: CGPoint(x: topLeftPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: topLeftPosY))

        //bottom left
        path.move(to: CGPoint(x: topLeftPosX, y: btmLeftPosY - lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: btmLeftPosY))

        //bottom right
        path.move(to: CGPoint(x: btmRightPosX - lineLength, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY - lineLength))

        //top right
        path.move(to: CGPoint(x: topRightPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topRightPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topRightPosX - lineLength, y: topLeftPosY))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 3
        shape.fillColor = UIColor.clear.cgColor
        
        self.qrCodeView.layer.insertSublayer(shape, at: 0)
    }
}
