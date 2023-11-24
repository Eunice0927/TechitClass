//
//  ViewController.swift
//  CameraDemo
//
//  Created by 박준영 on 11/24/23.
//

import UIKit

import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController,
                        UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    // 뒷 부분에서 필요할 Boolean 속성 선언
    var newMeida: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func useCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
            
            newMeida = true
        }
        
    }
    
    @IBAction func useCameraRoll(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            
            let imagePicker = UIImagePickerController()

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
            
            newMeida = false
        }
    }
    
}

