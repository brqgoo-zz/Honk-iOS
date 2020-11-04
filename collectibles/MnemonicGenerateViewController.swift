//
//  MnemonicGenerateViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 21.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import web3swift

class MnemonicGenerateViewController: UIViewController {

    @IBOutlet weak var generateButton: UIView!
    
    @IBOutlet weak var ph1: UITextField!
    @IBOutlet weak var ph2: UITextField!
    @IBOutlet weak var ph3: UITextField!
    @IBOutlet weak var ph4: UITextField!
    @IBOutlet weak var ph5: UITextField!
    @IBOutlet weak var ph6: UITextField!
    @IBOutlet weak var ph7: UITextField!
    @IBOutlet weak var ph8: UITextField!
    @IBOutlet weak var ph9: UITextField!
    @IBOutlet weak var ph10: UITextField!
    @IBOutlet weak var ph11: UITextField!
    @IBOutlet weak var ph12: UITextField!
    
    var mnemonicsStr:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        UIView.setAnimationsEnabled(true)
        
        mnemonicsStr = try! BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english)!
        
        ph1.text = "1. \(mnemonicsStr.components(separatedBy: " ")[0])"
        ph2.text = "2. \(mnemonicsStr.components(separatedBy: " ")[1])"
        ph3.text = "3. \(mnemonicsStr.components(separatedBy: " ")[2])"
        ph4.text = "4. \(mnemonicsStr.components(separatedBy: " ")[3])"
        ph5.text = "5. \(mnemonicsStr.components(separatedBy: " ")[4])"
        ph6.text = "6. \(mnemonicsStr.components(separatedBy: " ")[5])"
        ph7.text = "7. \(mnemonicsStr.components(separatedBy: " ")[6])"
        ph8.text = "8. \(mnemonicsStr.components(separatedBy: " ")[7])"
        ph9.text = "9. \(mnemonicsStr.components(separatedBy: " ")[8])"
        ph10.text = "10. \(mnemonicsStr.components(separatedBy: " ")[9])"
        ph11.text = "11. \(mnemonicsStr.components(separatedBy: " ")[10])"
        ph12.text = "12. \(mnemonicsStr.components(separatedBy: " ")[11])"
        
        
        generateButton.layer.shadowColor = UIColor.black.cgColor
        generateButton.layer.shadowOpacity = 0.07
        generateButton.layer.shadowOffset = .zero
        generateButton.layer.shadowRadius = 14
        generateButton.layer.cornerRadius = 14
        
        self.generateButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.doneViewTapped)))

        // Do any additional setup after loading the view.
    }
    
    @objc func doneViewTapped(sender : UITapGestureRecognizer) {
  
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.generateButton)
        
        let keystore = try! BIP32Keystore(
               mnemonics: mnemonicsStr,
           password: "",
           mnemonicsPassword: "",
               language: .english)!
           
           let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
           
           UserDefaults.standard.set(keyData, forKey: "keyData")
           
           
           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let newViewController = storyBoard.instantiateViewController(withIdentifier: "InitViewController") as! InitViewController
           self.navigationController?.pushViewController(newViewController, animated: true)
        
        }
    
    func animateButton(sender: UIView) {
        
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
