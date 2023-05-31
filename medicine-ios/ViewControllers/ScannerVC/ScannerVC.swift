//
//  ScannerVC.swift
//  medicine-ios
//
//  Created by MAC on 14/06/21.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var qrView: UIView!
    var captureSession: AVCaptureSession!
      var previewLayer: AVCaptureVideoPreviewLayer!

      override func viewDidLoad() {
          super.viewDidLoad()

        qrView.backgroundColor = UIColor.black
          captureSession = AVCaptureSession()

          guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
          let videoInput: AVCaptureDeviceInput

          do {
              videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
          } catch {
              return
          }

          if (captureSession.canAddInput(videoInput)) {
              captureSession.addInput(videoInput)
          } else {
              failed()
              return
          }

          let metadataOutput = AVCaptureMetadataOutput()

          if (captureSession.canAddOutput(metadataOutput)) {
              captureSession.addOutput(metadataOutput)

              metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//              metadataOutput.metadataObjectTypes = [.qr]
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]

          } else {
              failed()
              return
          }

          previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
          previewLayer.frame = qrView.layer.bounds
          previewLayer.videoGravity = .resizeAspectFill
        qrView.layer.addSublayer(previewLayer)

          captureSession.startRunning()
      }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
      func failed() {
          let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
          ac.addAction(UIAlertAction(title: "OK", style: .default))
          present(ac, animated: true)
          captureSession = nil
      }

      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)

          if (captureSession?.isRunning == false) {
              captureSession.startRunning()
          }
      }

      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)

          if (captureSession?.isRunning == true) {
              captureSession.stopRunning()
          }
      }

      func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
          captureSession.stopRunning()

          if let metadataObject = metadataObjects.first {
              guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
              guard let stringValue = readableObject.stringValue else { return }
              AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
              found(code: stringValue)
          }

          dismiss(animated: true)
      }

      func found(code: String) {
          print(code)
        let vc = storyboard?.instantiateViewController(withIdentifier: "QrDetailVC") as! QrDetailVC
        vc.userID = code
        self.navigationController?.pushViewController(vc, animated: true)
      }

      override var prefersStatusBarHidden: Bool {
          return true
      }

      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
          return .portrait
      }
  }
    
    
    
  
