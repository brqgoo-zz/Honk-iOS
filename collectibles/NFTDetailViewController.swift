//
//  NFTDetailViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class NFTDetailViewController: UIViewController {
    

    var NFTIconImage = UIImage()
    var titlee:String = "a"
    
    @IBOutlet weak var NFTIconImageView: UIImageView!
    
    
    
    //var NFTIconImage:UIImage
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func setTitle(_ titleStr:String){
        print("titlesi")
        title = titleStr

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
