//
//  DocumentViewController.swift
//  DocumentBrowserDemo
//
//  Created by 박준영 on 11/21/23.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet var documentText: UITextView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        document?.open(completionHandler: { (success) in
            if success {
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentText.text = self.document?.userText
            } else {
                
            }
        })
    }


    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func saveFile(_ sender: Any) {
        document?.userText = documentText.text
        
        if let url = document?.fileURL {
            document?.save(to: url, for: .forOverwriting, completionHandler: { (success) in
                if success {
                    print("File save OK!")
                } else {
                    print("File save failed!")
                }
            })
        } // end if
    }
    
    
}
