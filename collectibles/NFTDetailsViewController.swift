//
//  NFTDetailsViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 20.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class NFTDetailsViewController: UIViewController {
    
    var NFTProperties = [String: Any]()

    
    @IBOutlet weak var NFTImageView: UIImageView!
    @IBOutlet weak var NFTInfoTableView: UITableView!
    @IBOutlet weak var NFTViewOnExplorerTableView: UITableView!
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }

        viewDidLoad()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        NFTImageView.image = UIImage(named: NFTProperties["Icon"] as! String)!
        

        
        
        

        NFTInfoTableView.register(UINib(nibName: "NFTInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "NFTInfoTableViewCell")
        NFTInfoTableView.reloadData()
        
        NFTInfoTableView.frame.origin.x = -1
        NFTInfoTableView.frame.size.width = UIScreen.main.bounds.width + 2
        NFTInfoTableView.frame.origin.y = NFTImageView.frame.origin.y + NFTImageView.frame.size.height + NFTImageView.frame.size.height/20
        NFTInfoTableView.layer.borderColor = UIColor(named: "TableCellBorderColor")?.cgColor
        NFTInfoTableView.layer.borderWidth = 0.3
        NFTInfoTableView.frame = CGRect(x: NFTInfoTableView.frame.origin.x, y: NFTInfoTableView.frame.origin.y, width: NFTInfoTableView.frame.size.width, height: NFTInfoTableView.contentSize.height)
        
        
        NFTViewOnExplorerTableView.register(UINib(nibName: "ViewOnExplorerTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewOnExplorerTableViewCell")
        NFTViewOnExplorerTableView.reloadData()
        
        NFTViewOnExplorerTableView.frame.origin.x = -1
        NFTViewOnExplorerTableView.frame.size.width = UIScreen.main.bounds.width + 2
        NFTViewOnExplorerTableView.frame.origin.y = NFTInfoTableView.frame.origin.y + NFTInfoTableView.frame.size.height
        NFTViewOnExplorerTableView.layer.borderColor = UIColor(named: "TableCellBorderColor")?.cgColor
        NFTViewOnExplorerTableView.layer.borderWidth = 0.3
        NFTViewOnExplorerTableView.frame = CGRect(x: NFTViewOnExplorerTableView.frame.origin.x, y: NFTViewOnExplorerTableView.frame.origin.y, width: NFTViewOnExplorerTableView.frame.size.width, height: NFTViewOnExplorerTableView.contentSize.height)
        
        

        // Do any additional setup after loading the view.
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

extension NFTDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func fetchCollectibleNameFromSymbol(_ symbol:String)-> String{
        
        if symbol == "CK" {
            return "CryptoKitty"
        }
        
        else {
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == self.NFTViewOnExplorerTableView {
            tableView.deselectRow(at: IndexPath.init(row: 0, section: 0), animated: true)
            if let url = URL(string: "tg://addstickers?set=NFT\(NFTProperties["Identifier"] as! String)") {
                UIApplication.shared.open(url)
            }
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnInt = 0
        
        if tableView == self.NFTInfoTableView {
            returnInt = 5
        }
        else if tableView == self.NFTViewOnExplorerTableView {
            returnInt = 1
        }
        
        return returnInt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell!
        

        
        if tableView == self.NFTInfoTableView {
        
        
        
        let pcell = NFTInfoTableView.dequeueReusableCell(withIdentifier: "NFTInfoTableViewCell", for: indexPath) as! NFTInfoTableViewCell
        pcell.selectionStyle = .none
        pcell.backgroundColor = .clear

        
        

        if indexPath.row == 0 {
            pcell.title.text = "Name"
            pcell.dsc.text = NFTProperties["Symbol"] as? String
        }
        else if indexPath.row == 1 {
            pcell.title.text = "Identifier"
            pcell.dsc.text = "#\(NFTProperties["Identifier"] as! String)"
        }
        else if indexPath.row == 2 {
            pcell.title.text = "Added"
            pcell.dsc.text = "\(NFTProperties["Added"] as! Date)"
        }
        else if indexPath.row == 3 {
            pcell.title.text = "Network"
            pcell.dsc.text = "Ethereum Mainnet"
        }
        else if indexPath.row == 4 {
            pcell.title.text = "TxID"
            pcell.dsc.text = NFTProperties["TxID"] as? String
        }
            
            pcell.title.frame.origin.x = UIScreen.main.bounds.width / 14
            pcell.dsc.frame.origin.x = UIScreen.main.bounds.width / 2.8
            pcell.dsc.frame.size.width = UIScreen.main.bounds.width - pcell.dsc.frame.origin.x * 10 / 9
            
            cell = pcell


        }
        else if tableView == self.NFTViewOnExplorerTableView {
            
            let pcell = NFTViewOnExplorerTableView.dequeueReusableCell(withIdentifier: "ViewOnExplorerTableViewCell", for: indexPath) as! ViewOnExplorerTableViewCell
            pcell.selectionStyle = .default
            pcell.backgroundColor = .clear
            pcell.EtherScanNavigateButton.frame.origin.x = UIScreen.main.bounds.width / 14
            
            cell = pcell
            
        }
        
        
        
  
        

        return cell
    }
    
    
    
    
}
