//
//  AnalyticsViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 07.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import WebKit

class AnalyticsViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view3l1: UILabel!
    @IBOutlet weak var view3l2: UILabel!
    @IBOutlet weak var view3l3: UILabel!
    @IBOutlet weak var view1l1: UILabel!
    @IBOutlet weak var view2l1: UILabel!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view4l1: UILabel!
    @IBOutlet weak var view4l2: UILabel!
    @IBOutlet weak var view4l3: UILabel!
    @IBOutlet weak var view4l4: UILabel!
    @IBOutlet weak var view4l5: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("sdd");
        
        title = "Analytics"
        
        
        
        
        var etherPriceDouble:Double = Double(UserDefaults.standard.object(forKey: "etherPrice") as! Double)
        var honkPriceDouble:Double = Double(UserDefaults.standard.object(forKey: "honkPrice") as! Double)
        
        var honkToEtherStr:String = String(UserDefaults.standard.object(forKey: "honkToEther") as! Double)
        var honkPriceStr:String = String(honkPriceDouble)
        
        print("mk0")
        print(honkPriceStr)
            
        var start = honkToEtherStr.index(honkToEtherStr.startIndex, offsetBy: 0)
        var end = honkToEtherStr.index(honkToEtherStr.endIndex, offsetBy: (honkToEtherStr.count - 6) * -1)
        var range = start..<end
        honkToEtherStr = honkToEtherStr[range] + ""
        
        honkPriceStr = honkPriceStr.components(separatedBy: ".")[0] + "." + honkPriceStr.components(separatedBy: ".")[1].prefix(2)
        
        view1l1.text = "1 HONK =  \(honkToEtherStr) ETH ($\(honkPriceStr))"
        
        
        
        var etherToHonkStr:String = String(UserDefaults.standard.object(forKey: "etherToHonk") as! Double)
        let etherPriceStr:String = String(etherPriceDouble)
            
        start = etherToHonkStr.index(etherToHonkStr.startIndex, offsetBy: 0)
        end = etherToHonkStr.index(etherToHonkStr.endIndex, offsetBy: (etherToHonkStr.count - 6) * -1)
        range = start..<end
        etherToHonkStr = etherToHonkStr[range] + ""
        
        
        view2l1.text = "1 ETH =  \(etherToHonkStr) HONK ($\(etherPriceStr))"
        

        
        
        
        var viewgap:Int = Int(view1.frame.size.height / 3)
        
        
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 0.05
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 8
        view1.layer.cornerRadius = 8
        view1.frame.size.width = self.view.bounds.width * 92 / 100
        view1.frame.origin.x = (self.view.bounds.width - (view1.frame.size.width))/2
        
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 0.05
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 8
        view2.layer.cornerRadius = 8
        view2.frame.size.width = self.view.bounds.width * 92 / 100
        view2.frame.origin.x = (self.view.bounds.width - (view2.frame.size.width))/2
        view2.frame.origin.y = view1.frame.origin.y + view2.frame.size.height + CGFloat(viewgap)
        
        view3.layer.shadowColor = UIColor.black.cgColor
        view3.layer.shadowOpacity = 0.05
        view3.layer.shadowOffset = .zero
        view3.layer.shadowRadius = 8
        view3.layer.cornerRadius = 8
        view3.frame.size.width = self.view.bounds.width * 92 / 100
        view3.frame.origin.x = (self.view.bounds.width - (view3.frame.size.width))/2
        view3.frame.origin.y = view2.frame.origin.y + view2.frame.size.height + CGFloat(viewgap)
        view3l3.frame.origin.x = view3.frame.size.width - view3l3.frame.size.width * 100 / 85
        
        view4.layer.shadowColor = UIColor.black.cgColor
        view4.layer.shadowOpacity = 0.05
        view4.layer.shadowOffset = .zero
        view4.layer.shadowRadius = 8
        view4.layer.cornerRadius = 8
        view4.frame.size.width = self.view.bounds.width * 92 / 100
        view4.frame.origin.x = (self.view.bounds.width - (view4.frame.size.width))/2
        view4.frame.origin.y = view3.frame.origin.y + view3.frame.size.height + CGFloat(viewgap)
        view4l5.frame.origin.x = view4.frame.size.width - view4l5.frame.size.width * 100 / 85
        
        var honkPooledStr = String(UserDefaults.standard.object(forKey: "honkPooled") as! Double)
        var etherPooledStr = String(UserDefaults.standard.object(forKey: "etherPooled") as! Double)
        
        view4l2.text = toUSDStr(str: honkPooledStr.components(separatedBy: ".")[0]) + "." + honkPooledStr.components(separatedBy: ".")[1].prefix(2) + " HONK"
        view4l3.text = toUSDStr(str: etherPooledStr.components(separatedBy: ".")[0]) + "." + etherPooledStr.components(separatedBy: ".")[1].prefix(2) + " ETH"
        
        var totalLPSupplyStr = String(UserDefaults.standard.object(forKey: "totalLPSupply") as! Double)
        totalLPSupplyStr = toUSDStr(str: totalLPSupplyStr.components(separatedBy: ".")[0]) + "." + totalLPSupplyStr.components(separatedBy: ".")[1].prefix(2)
        
        view4l4.text = "\(totalLPSupplyStr) LP"
        
        let honkPooledUSD:Double = Double(UserDefaults.standard.object(forKey: "honkPooled") as! Double) * honkPriceDouble
        let etherPooledUSD:Double = Double(UserDefaults.standard.object(forKey: "etherPooled") as! Double) * etherPriceDouble
        let totalPooledUSD = honkPooledUSD + etherPooledUSD
        var totalPooledUSDStr = String(honkPooledUSD + etherPooledUSD).components(separatedBy: ".")[0]
        

        
        view3l2.text = "$\(toUSDStr(str: totalPooledUSDStr))"
        
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func toUSDStr(str:String) -> String{
        
        var strconvert = str
        
        if(strconvert.count == 4){
            strconvert = "\(strconvert.prefix(1)),\(strconvert.prefix(3))"
        } else if(strconvert.count == 5){
            strconvert = "\(strconvert.prefix(2)),\(strconvert.prefix(3))"
        } else if(str.count == 6){
            strconvert = "\(strconvert.prefix(3)),\(strconvert.prefix(3))"
        }
        else if(strconvert.count == 7){
            strconvert = "\(strconvert.prefix(1)),\(strconvert.prefix(3)),\(strconvert.prefix(3))"
        }
        else if(strconvert.count == 8){
            strconvert = "\(strconvert.prefix(2)),\(strconvert.prefix(3)),\(strconvert.prefix(3))"
        }
        else if(str.count == 9){
            strconvert = "\(strconvert.prefix(3)),\(strconvert.prefix(3)),\(strconvert.prefix(3))"
        }
        return strconvert
    }

}
