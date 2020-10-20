//
//  MnemonicLoginViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import web3swift

class InitViewController: UIViewController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.setAnimationsEnabled(false)
        
        if UserDefaults.standard.object(forKey: "keyData") != nil{
            
            print("existing userPrivateKeyStr")

            
            performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }
        else {

            print("new userPrivateKeyStr")
            
            /*
            let keystore = try! BIP32Keystore(
            mnemonics: "faith unfair shell cave second tennis wall similar spy fat flag certain",
            password: "",
            mnemonicsPassword: "",
                language: .english)!
            
            let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
            
            UserDefaults.standard.set(keyData, forKey: "keyData")
 */
            
            performSegue(withIdentifier: "newUserSegue", sender: nil)
            
            
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

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension Data {
    public init(hex: String) {
        self.init(_: Array<UInt8>(hex: hex))
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
