//
//  ViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 14.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import CoreNFC
import web3swift
import Network
import BigInt
import CryptoKit
import SwiftyJSON
import UInt256


class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    var selectedModel:Int = 0
    var collectiblesArray = [[String: Any]]()

    @IBOutlet weak var CollectiblesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "collectiblesArrayKey") != nil{
            
            collectiblesArray = UserDefaults.standard.object(forKey: "collectiblesArrayKey") as! [[String : Any]]
            
        }
        
        title = "Collection"
        self.navigationItem.title = "My Collection"
        


        
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        CollectiblesTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        CollectiblesTableView.rowHeight = 12.00
        CollectiblesTableView.separatorColor = .red
        CollectiblesTableView.rowHeight = 132.4
        CollectiblesTableView.separatorStyle = .none
        CollectiblesTableView.backgroundColor = UIColor(named: "BackgroundColor")
        CollectiblesTableView.reloadData()
        
   
        
        
    }

    
    func hex2ascii (_ example: String) -> String {

        var chars = [Character]()

        for c in example {
            chars.append(c)
        }

        let numbers =  stride(from: 0, to: chars.count, by: 2).map{
            strtoul(String(chars[$0 ..< $0+2]), nil, 16)
        }

        var final = ""
        var i = 0

        while i < numbers.count {
            final.append(Character(UnicodeScalar(Int(numbers[i]))!))
            i += 1
        }

        return final
    }

    
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {

        for message in messages {
            for record in message.records {
                
                session.invalidate()
                
                print("record.payload.bytes.count")
                print(record.payload.bytes.count)
                if record.payload.bytes.count >= 100{

                }
                else {
                    self.alert("Invalid NFC Tag.")
                }
                
            }
        }
    }
    
    func afterReaderSession(_ tagString:String) {

        
                    
            }

    
    func alert(_ errorDescription:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func warning(_ errorDescription:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func collectibleSymbolDecode(_ symbol:String)->String{
        
        if(symbol=="CK"){
            return "CryptoKitty"
        }
        else {
            return ""
        }
        
    }
    
    

    func addCollectibleUIInit (_ NFT_SYMBOL:String, _ NFT_IDENTIFIER:String, _ NFT_OWNER_ETH_ADDRESS_STR:String, _ NFT_OWNER_PRIVATE_KEY:String, _ web3:web3, _ Userwallet:Wallet){
        
        DispatchQueue.main.async {
            
            var collectibleImageURL = URL(string: "")
            
            if NFT_SYMBOL == "CK"{
 
                let semaphore = DispatchSemaphore (value: 0)
  
                var request = URLRequest(url: URL(string: "https://public.api.cryptokitties.co/v1/kitties?kittyId=\(NFT_IDENTIFIER)")!,timeoutInterval: Double.infinity)
                request.addValue("HF3rRlVT6fO9ZpsASQuWdu75XUD9B_qFVK6TKIsfVg0", forHTTPHeaderField: "x-api-token")
                request.httpMethod = "GET"
                
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    print("dataencodedis")
                    print(String(data: data, encoding: .utf8)!)
                    
                    if(String(data: data, encoding: .utf8)! == "Service Unavailable"){
                    }
                    else {
                        let collectibleJSONDecodedCryptoKitty: CryptoKitty = try! JSONDecoder().decode(CryptoKitty.self, from: data)
                        collectibleImageURL = URL(string: collectibleJSONDecodedCryptoKitty.kitties[0].image_url_png)!
                    }

                    semaphore.signal()
                }
                
                task.resume()
                semaphore.wait()
            }
            
            DispatchQueue.main.async {
                
                print("collectibleImageURLis")
                print(collectibleImageURL?.absoluteString)
                
                if(collectibleImageURL?.absoluteString != nil){
                    
                
                let imageView = UIImageView(frame: CGRect(x: 34, y: 45, width: 290, height: 290))
                
                
                func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                }
                
                getData(from: collectibleImageURL!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? collectibleImageURL!.lastPathComponent)
                    print("Download Finished")
                    DispatchQueue.main.async() { [weak self] in
                        
                        print("data.count")
                        print(data.count)
                        
                        imageView.image = UIImage(data: data)

                        //imageView.image = UIImage(named: "\(collectibleIdentifier).png")
                        
                        let alertController = UIAlertController(title: "\(self!.collectibleSymbolDecode(NFT_SYMBOL)) Detected!", message: "Do you want to add \(self!.collectibleSymbolDecode(NFT_SYMBOL) + " #" + NFT_IDENTIFIER) to your collectible collection?\n \n \n \n \n \n \n \n \n \n \n \n \n", preferredStyle: .actionSheet)
                        
                        
                        let action1 = UIAlertAction(title: "Add", style: .default) { (action) in
                            if action.isEnabled {
                                
                                
                                
                                
                                let value: String = "0.0" // In Ether
                                let toAddress = EthereumAddress(self!.fetchETHContractAddressFromSymbol(NFT_SYMBOL))!
                                   let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
                                   let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
                                   var options = TransactionOptions.defaultOptions
                                   options.value = amount
                                   options.from = EthereumAddress(NFT_OWNER_ETH_ADDRESS_STR)!
                                options.gasPrice = .manual(40000000000)
                                options.gasLimit = .manual(65000)
                                   
                                   let tx = contract.write(
                                       "fallback",
                                       parameters: [AnyObject](),
                                       extraData: Data(hex: self!.txDataEncode(symbol: NFT_SYMBOL, toAddress: Userwallet.address, identifier: NFT_IDENTIFIER)),

                                       
                                       transactionOptions: options)!
                                   
                                var TXResult:TransactionSendingResult
                                
                                do {
                                    TXResult = try tx.send(password: "")
                                    
                                       print("TXResult HASH")
                                      print(TXResult.hash)
                                    
                                    if TXResult.hash.count == 66 {
                                        
                                        print("asama1 suc, 2 gecildi")
                                        
                                        let value: String = "0.002" // In Ether
                                        let toAddress = EthereumAddress(Userwallet.address)!
                                           let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
                                           let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
                                           var options = TransactionOptions.defaultOptions
                                           options.value = amount
                                           options.from = EthereumAddress(NFT_OWNER_ETH_ADDRESS_STR)!
                                        options.gasPrice = .manual(40000000000)
                                        options.gasLimit = .manual(21000)
                                           
                                           let tx2 = contract.write(
                                               "fallback",
                                               parameters: [AnyObject](),
                                               extraData: Data(),
                                               transactionOptions: options)!
                                        
                                        var TXResult2:TransactionSendingResult
                                        
                                        do {
                                            print("2 do")
                                            TXResult2 = try tx2.send(password: "")
                                            
                                            if TXResult2.hash.count == 66 {
                                                print("2 do 1")
                                                self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": TXResult2.hash])
                                                
                                                UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                                self!.viewDidLoad()
          
                                            }
                                            else {
                                                
                                                print("2 do 2")
                                                
                                                self!.warning("Credentials Added, but ETH transaction failed :v2")
                                                
                                                self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": ""])
                                                
                                                UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                                self!.viewDidLoad()
                                                
                                            }
                                            

                                            
                                        }
                                            
                                        catch {
                                            
                                            print("2 catch")
                                            
                                            self!.warning("Credentials Added, but ETH transaction failed :v1")
                                            
                                            self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": ""])
                                            
                                            UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                            self!.viewDidLoad()
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        

                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    else {
                                        self!.alert("An error occured :a805")
                                    }
                                    
                                }
                                catch {
                                    self!.alert("An error occured! :tx1")
                                }
    
                            }
                            else {
                                self!.alert("Service Unavailable.")
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        alertController.addAction(action1)
                        alertController.addAction(cancelAction)
                        self!.present(alertController, animated: true, completion: nil)
                        alertController.view.addSubview(imageView)
                    }
                }
                
                
                //imageView.image = UIImage(named: "\(collectibleIdentifier).png")
                
                
                
                
                
                }
            }

        
        
        
    }
    
    
}
    
    func  txDataEncode(symbol:String, toAddress:String, identifier:String)->String{
        
        var returnDataStr:String = ""
        
        let identifierInt = Int(identifier)
        let encodedIdentifier =  String(format:"%02X", identifierInt!)
        
        

        
        //1
        if(symbol=="CK"){
            returnDataStr += "a9059cbb"
        }
        
        //2
        returnDataStr += "000000000000000000000000" + toAddress.components(separatedBy: "0x")[1]
        
        //3
        let leaddingZeroCount = 64 - encodedIdentifier.count
        
        for _ in 1...leaddingZeroCount {
            returnDataStr += "0"
        }
        
        returnDataStr += encodedIdentifier
        
        print("returnDataStr is: \(returnDataStr)")
        
        
        return returnDataStr
        
    }
    
    func fetchETHContractAddressFromSymbol(_ symbol:String)-> String{
        
        if symbol == "CK" {
            return "0x06012c8cf97bead5deae237070f9587f8e7a266d"
        }
        
        else {
            self.alert("Symbol '\(symbol)' is not supported.")
            return ""
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? NFTDetailsViewController {

            destination.title = "\(collectiblesArray[selectedModel]["Symbol"]!) #\(collectiblesArray[selectedModel]["Identifier"]!)"
            destination.NFTProperties = collectiblesArray[selectedModel]
            
        }
    }

    
    
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //indexPath.row
       // let credential = credentials[indexPath.row]
        
        
        
            //let vc = NFTDetailViewController()
            //vc.setTitle("naeeer")

            selectedModel = indexPath.row
 
            performSegue(withIdentifier: "viewNFTDetails", sender: self)

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectiblesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CollectiblesTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.TableCellView.layer.cornerRadius = 8
        cell.TitleLabel.text = "\(collectiblesArray[indexPath.row]["Symbol"] ?? "")"
        cell.DescriptionLabel.text = "#\(collectiblesArray[indexPath.row]["Identifier"] ?? "")"
        cell.IconView.image = UIImage(named: collectiblesArray[indexPath.row]["Icon"] as! String)
        cell.TableCellView.layer.shadowColor = UIColor.black.cgColor
        cell.TableCellView.layer.shadowOpacity = 0.05
        cell.TableCellView.layer.shadowOffset = .zero
        cell.TableCellView.layer.shadowRadius = 8
        return cell
    }
    
    
    
    
}

