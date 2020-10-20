//
//  MnemonicEnterViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class MnemonicEnterViewController: UIViewController {
    @IBOutlet weak var doneView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneView.layer.shadowColor = UIColor.black.cgColor
        doneView.layer.shadowOpacity = 0.07
        doneView.layer.shadowOffset = .zero
        doneView.layer.shadowRadius = 14
        doneView.layer.cornerRadius = 14
        
        self.doneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.doneViewTapped)))
        // Do any additional setup after loading the view.
    }
    
    @objc func doneViewTapped(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.doneView)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
