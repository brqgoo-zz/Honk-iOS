//
//  NewUserViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var importView: UIView!
    @IBOutlet weak var generateView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.setAnimationsEnabled(true)
        
        // Do any additional setup after loading the view.
        
        importView.layer.shadowColor = UIColor.black.cgColor
        importView.layer.shadowOpacity = 0.07
        importView.layer.shadowOffset = .zero
        importView.layer.shadowRadius = 14
        importView.layer.cornerRadius = 14
        
        generateView.layer.shadowColor = UIColor.black.cgColor
        generateView.layer.shadowOpacity = 0.07
        generateView.layer.shadowOffset = .zero
        generateView.layer.shadowRadius = 14
        generateView.layer.cornerRadius = 14
        
        self.importView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.importTapped)))
        self.generateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.generateTapped)))

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func generateTapped(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.generateView)
    }
    
    @objc func importTapped(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.importView)
        
        performSegue(withIdentifier: "importSegue", sender: nil)
        
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

}
