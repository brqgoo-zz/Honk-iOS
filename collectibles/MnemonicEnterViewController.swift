//
//  MnemonicEnterViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import web3swift

class MnemonicEnterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var doneView: UIView!
    
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
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        UIView.setAnimationsEnabled(true)
        

        doneView.layer.shadowColor = UIColor.black.cgColor
        doneView.layer.shadowOpacity = 0.07
        doneView.layer.shadowOffset = .zero
        doneView.layer.shadowRadius = 14
        doneView.layer.cornerRadius = 14
        
        doneView.alpha = 0.5
        

        ph1.returnKeyType = UIReturnKeyType.done
        ph2.returnKeyType = UIReturnKeyType.done
        ph3.returnKeyType = UIReturnKeyType.done
        ph4.returnKeyType = UIReturnKeyType.done
        ph5.returnKeyType = UIReturnKeyType.done
        ph6.returnKeyType = UIReturnKeyType.done
        ph7.returnKeyType = UIReturnKeyType.done
        ph8.returnKeyType = UIReturnKeyType.done
        ph9.returnKeyType = UIReturnKeyType.done
        ph10.returnKeyType = UIReturnKeyType.done
        ph11.returnKeyType = UIReturnKeyType.done
        ph12.returnKeyType = UIReturnKeyType.done
        
        
        ph1.delegate = self
        ph2.delegate = self
        ph3.delegate = self
        ph4.delegate = self
        ph5.delegate = self
        ph6.delegate = self
        ph7.delegate = self
        ph8.delegate = self
        ph9.delegate = self
        ph10.delegate = self
        ph11.delegate = self
        ph12.delegate = self
      
        ph1.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph2.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph3.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph4.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph5.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph6.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph7.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph8.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph9.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph10.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph11.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        ph12.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
   
        self.doneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.doneViewTapped)))
        // Do any additional setup after loading the view.
    }

    
    @objc func doneViewTapped(sender : UITapGestureRecognizer) {
        

        
        
        if(doneView.alpha >= 1) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.doneView)
            
            do {
                let keystore = try BIP32Keystore(
                    mnemonics: "\(ph1.text!) \(ph2.text!) \(ph3.text!) \(ph4.text!) \(ph5.text!) \(ph6.text!) \(ph7.text!) \(ph8.text!) \(ph9.text!) \(ph10.text!) \(ph11.text!) \(ph12.text!)",
                password: "",
                mnemonicsPassword: "",
                    language: .english)!
                
                let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
                
                UserDefaults.standard.set(keyData, forKey: "keyData")
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "InitViewController") as! InitViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
                
                
                //performSegue(withIdentifier: "aftermnomonicSegue", sender: nil)
            }
            catch {
                let dialogMessage = UIAlertController(title: "Error", message: "One or more passphrase not valid.", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
            }
            
            
            
        
    }
        
        //performSegue(withIdentifier: "importSegue", sender: nil)
        
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
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        
     
        if (ph1.text!.count >= 3 && ph2.text!.count >= 3 && ph3.text!.count >= 3 && ph4.text!.count >= 3 && ph5.text!.count >= 3 && ph6.text!.count >= 3 && ph7.text!.count >= 3  && ph8.text!.count >= 3 && ph9.text!.count >= 3 && ph10.text!.count >= 3 && ph11.text!.count >= 3 && ph12.text!.count >= 3){
            doneView.alpha = 1
            print("asddsa")
        }
        else {
            doneView.alpha = 0.5
        }


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

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

func restartApplication () {
    let viewController = InitViewController()
    let navCtrl = UINavigationController(rootViewController: viewController)

    guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
        return
    }

    navCtrl.view.frame = rootViewController.view.frame
    navCtrl.view.layoutIfNeeded()

    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
        window.rootViewController = navCtrl
    })

}
