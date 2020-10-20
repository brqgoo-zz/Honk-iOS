//
//  WalletViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 14.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import CryptoKit
import web3swift
import Network
import UInt256
import BigInt


struct Wallet {
    let address: String
    let data: Data
    let name: String
    let isHD: Bool
    var ethBalance: BigUInt
}

struct HDKey {
    let name: String?
    let address: String
}

class WalletViewController: UIViewController {
    
    
    
    @IBOutlet weak var honkTab: UIView!
    @IBOutlet weak var lolTab: UIView!
    @IBOutlet weak var uniTab: UIView!
    @IBOutlet weak var ethTab: UIView!
    
    @IBOutlet weak var honkTab_lb1: UILabel!
    @IBOutlet weak var honkTab_lb2: UILabel!
    
    @IBOutlet weak var lolTab_lb1: UILabel!
    @IBOutlet weak var lolTab_lb2: UILabel!
    
    @IBOutlet weak var uniTab_lb1: UILabel!
    @IBOutlet weak var uniTab_lb2: UILabel!
    
    @IBOutlet weak var ethTab_lb1: UILabel!
    @IBOutlet weak var ethTab_lb2: UILabel!
    
    
    
    
    var userWallet = Wallet(address: "", data: Data(), name: "", isHD: false, ethBalance: 0)
    var userPrivateKeyStr = ""
    
    let uniV2HonkContractABI = "[{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount0\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount1\",\"type\":\"uint256\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"Burn\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount0\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount1\",\"type\":\"uint256\"}],\"name\":\"Mint\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount0In\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount1In\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount0Out\",\"type\":\"uint256\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount1Out\",\"type\":\"uint256\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"Swap\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"uint112\",\"name\":\"reserve0\",\"type\":\"uint112\"},{\"indexed\":false,\"internalType\":\"uint112\",\"name\":\"reserve1\",\"type\":\"uint112\"}],\"name\":\"Sync\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"constant\":true,\"inputs\":[],\"name\":\"DOMAIN_SEPARATOR\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"MINIMUM_LIQUIDITY\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"PERMIT_TYPEHASH\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"burn\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"amount0\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"amount1\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"factory\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"getReserves\",\"outputs\":[{\"internalType\":\"uint112\",\"name\":\"_reserve0\",\"type\":\"uint112\"},{\"internalType\":\"uint112\",\"name\":\"_reserve1\",\"type\":\"uint112\"},{\"internalType\":\"uint32\",\"name\":\"_blockTimestampLast\",\"type\":\"uint32\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"_token0\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_token1\",\"type\":\"address\"}],\"name\":\"initialize\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"kLast\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"mint\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"liquidity\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"name\":\"nonces\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"deadline\",\"type\":\"uint256\"},{\"internalType\":\"uint8\",\"name\":\"v\",\"type\":\"uint8\"},{\"internalType\":\"bytes32\",\"name\":\"r\",\"type\":\"bytes32\"},{\"internalType\":\"bytes32\",\"name\":\"s\",\"type\":\"bytes32\"}],\"name\":\"permit\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"price0CumulativeLast\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"price1CumulativeLast\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"skim\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"amount0Out\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"amount1Out\",\"type\":\"uint256\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"bytes\",\"name\":\"data\",\"type\":\"bytes\"}],\"name\":\"swap\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"sync\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"token0\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"token1\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"

    let honkContractABI = "[{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"total\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"tokenOwner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"constant\":true,\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"delegate\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"delegate\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"numTokens\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"internalType\":\"address\",\"name\":\"tokenOwner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"receiver\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"numTokens\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"buyer\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"numTokens\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"

        
        

        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.setAnimationsEnabled(true)
        
        title = "Wallet"
        self.navigationItem.title = "My Wallet"
       
        self.honkTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionHongTab)))
        self.lolTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionLolTab)))
        self.uniTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionUniTab)))
        self.ethTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionEthTab)))
        
        var viewgap:Int = Int(honkTab.frame.size.height / 7)
        
        
        honkTab.layer.shadowColor = UIColor.black.cgColor
        honkTab.layer.shadowOpacity = 0.07
        honkTab.layer.shadowOffset = .zero
        honkTab.layer.shadowRadius = 8
        honkTab.layer.cornerRadius = 8
        honkTab.frame.size.width = self.view.bounds.width * 92 / 100
        honkTab.frame.origin.x = (self.view.bounds.width - (honkTab.frame.size.width))/2
        
        lolTab.layer.shadowColor = UIColor.black.cgColor
        lolTab.layer.shadowOpacity = 0.07
        lolTab.layer.shadowOffset = .zero
        lolTab.layer.shadowRadius = 8
        lolTab.layer.cornerRadius = 8
        lolTab.frame.size.width = self.view.bounds.width * 92 / 100
        lolTab.frame.origin.x = (self.view.bounds.width - (honkTab.frame.size.width))/2
        lolTab.frame.origin.y = honkTab.frame.origin.y + lolTab.frame.size.height + CGFloat(viewgap)
        
        uniTab.layer.shadowColor = UIColor.black.cgColor
        uniTab.layer.shadowOpacity = 0.07
        uniTab.layer.shadowOffset = .zero
        uniTab.layer.shadowRadius = 8
        uniTab.layer.cornerRadius = 8
        uniTab.frame.size.width = self.view.bounds.width * 92 / 100
        uniTab.frame.origin.x = (self.view.bounds.width - (honkTab.frame.size.width))/2
        uniTab.frame.origin.y = lolTab.frame.origin.y + uniTab.frame.size.height + CGFloat(viewgap)
        
        ethTab.layer.shadowColor = UIColor.black.cgColor
        ethTab.layer.shadowOpacity = 0.07
        ethTab.layer.shadowOffset = .zero
        ethTab.layer.shadowRadius = 8
        ethTab.layer.cornerRadius = 8
        ethTab.frame.size.width = self.view.bounds.width * 92 / 100
        ethTab.frame.origin.x = (self.view.bounds.width - (honkTab.frame.size.width))/2
        ethTab.frame.origin.y = uniTab.frame.origin.y + ethTab.frame.size.height + CGFloat(viewgap)
        
        
        //navigationController!.navigationBar.addSubview(optionsButton)
        


        var web3Infura = Web3.InfuraMainnetWeb3()
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                web3Infura = web3(provider: Web3HttpProvider(URL(string: "https://mainnet.infura.io/v3/444215a4372f452da1f9248cb4633305")!)!)
            }
        }
        
        let keyData = UserDefaults.standard.object(forKey: "keyData") as! Data
        let keystore = BIP32Keystore(keyData)!
        let keystoreManager = KeystoreManager([keystore])
        
        userWallet = Wallet(address: keystore.addresses!.first!.address, data: keyData, name: "userWallet", isHD: true, ethBalance: 0)
        web3Infura.addKeystoreManager(keystoreManager)

         
        print("UserETHAddress is")
        print(userWallet.address)
        
        
        //get ether price
        
        let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            UserDefaults.standard.set(Double(String(data: data, encoding: .utf8)!.components(separatedBy: "\"USD\":")[1].components(separatedBy: "}")[0]), forKey: "etherPrice")
        }

        task.resume()
        
        
        //reading univ2 honk contract
        
        let contract_honk_uni = web3Infura.contract(uniV2HonkContractABI, at: EthereumAddress("0xa02106d4a9ac9a8c86223f31be2493a2f6234fe8"), abiVersion: 2)
        
        let contract_honk = web3Infura.contract(honkContractABI, at: EthereumAddress("0x43b1243e9045cda9cfdc3d3bf191bb88e3fc34d9"), abiVersion: 2)
        
        let amount = Web3.Utils.parseToBigUInt("0", units: .eth)
        
        
        var options = TransactionOptions.defaultOptions
        options.value = amount
        options.from = EthereumAddress(userWallet.address) 
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        
        
        let tx = contract_honk_uni?.read(
                "getReserves",
                parameters: [] as [AnyObject],
                extraData: Data(),
                transactionOptions: options)!
        
        let tx2 = contract_honk_uni?.read(
                "totalSupply",
                parameters: [] as [AnyObject],
                extraData: Data(),
                transactionOptions: options)!
        
        let tx3 = contract_honk_uni?.read(
        "balanceOf",
        //parameters: [] as [AnyObject],
        parameters: [EthereumAddress(userWallet.address)!] as [AnyObject],
        extraData: Data(),
        transactionOptions: options)!
        
        let tx4 = contract_honk?.read(
        "balanceOf",
        //parameters: [] as [AnyObject],
        parameters: [EthereumAddress(userWallet.address)!] as [AnyObject],
        extraData: Data(),
        transactionOptions: options)!
        
        
        var ethBalanceResult:BigUInt = 0
        var txCallResult:[String : Any] = ["":""]
        var tx2CallResult:[String : Any] = ["":""]
        var tx3CallResult:[String : Any] = ["":""]
        var tx4CallResult:[String : Any] = ["":""]
        
        
              do {
        
                  ethBalanceResult = try web3Infura.eth.getBalance(address: EthereumAddress(userWallet.address)!)
                  txCallResult = try tx!.call()
                  tx2CallResult = try tx2!.call()
                  tx3CallResult = try tx3!.call()
                  tx4CallResult = try tx4!.call()
                
                
                print("ethBalanceResult")
                print(ethBalanceResult)
                
            print("tx4CallResult")
                print(tx4CallResult)
                
                UserDefaults.standard.set(Decimal(string: String(ethBalanceResult))! / 1000000000000000000, forKey: "ethBalance")
                UserDefaults.standard.set(Decimal(string: String((tx3CallResult["0"] as! NSObject).description))! / 1000000000000000000, forKey: "lpBalance")
                  
                  //balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3) ?? "0"
                  UserDefaults.standard.set(Decimal(string: String((txCallResult["0"] as! NSObject).description))! / 1000000000000000000, forKey: "honkPooled")
                  UserDefaults.standard.set(Decimal(string: String((txCallResult["1"] as! NSObject).description))! / 1000000000000000000, forKey: "etherPooled")
                  UserDefaults.standard.set(((UserDefaults.standard.object(forKey: "etherPooled") as! Double) / (UserDefaults.standard.object(forKey: "honkPooled") as! Double)) * Double(UserDefaults.standard.object(forKey: "etherPrice") as! Double), forKey: "honkPrice")
                  UserDefaults.standard.set(((UserDefaults.standard.object(forKey: "etherPooled") as! Double) / (UserDefaults.standard.object(forKey: "honkPooled") as! Double)), forKey: "honkToEther")
                  UserDefaults.standard.set(((UserDefaults.standard.object(forKey: "honkPooled") as! Double) / (UserDefaults.standard.object(forKey: "etherPooled") as! Double)), forKey: "etherToHonk")
                  
                  UserDefaults.standard.set(Decimal(string: String((tx2CallResult["0"] as! NSObject).description))! / 1000000000000000000, forKey: "totalLPSupply")
                  UserDefaults.standard.set(Decimal(string: String((tx4CallResult["0"] as! NSObject).description))! / 1000000000000000000, forKey: "honkBalance")
                
                
                
                
                setTabLabels()


              } catch {

                
                setTabLabels()
                  print("eroor")
              }

        // Do any additional setup after loading the view.
    }
    
    func setTabLabels(){
        
        
        if (Double(UserDefaults.standard.object(forKey: "honkBalance") as! Double) >= 0.00001){
            let etherBalanceStr = String(Double(UserDefaults.standard.object(forKey: "honkBalance") as! Double))
            honkTab_lb1.text = toUSDStr(str: etherBalanceStr.components(separatedBy: ".")[0]) + "." + etherBalanceStr.components(separatedBy: ".")[1].prefix(5) + " HONK"
            
            let honkPriceDouble:Double = Double(UserDefaults.standard.object(forKey: "honkPrice") as! Double)
            let etherBalanceUSD:Double = Double(UserDefaults.standard.object(forKey: "honkBalance") as! Double) * honkPriceDouble
            honkTab_lb2.text = "$\(toUSDStr(str: String(etherBalanceUSD).components(separatedBy: ".")[0]) + "." + String(etherBalanceUSD).components(separatedBy: ".")[1].prefix(2))"
        }
        else {
            honkTab_lb1.text = "0 HONK"
            honkTab_lb2.text = "$0"
        }
        
        
        lolTab_lb1.text = "0 LOL"
        lolTab_lb2.text = "$0"
        
        
        if (Double(UserDefaults.standard.object(forKey: "lpBalance") as! Double) >= 0.00001){
            let lpBalanceStr = String(Double(UserDefaults.standard.object(forKey: "lpBalance") as! Double))
            uniTab_lb1.text = toUSDStr(str: lpBalanceStr.components(separatedBy: ".")[0]) + "." + lpBalanceStr.components(separatedBy: ".")[1].prefix(2) + " LP"
            
            let lpPctStr = String(Double(UserDefaults.standard.object(forKey: "lpBalance") as! Double) / Double(UserDefaults.standard.object(forKey: "totalLPSupply") as! Double) * 100)
            uniTab_lb2.text = "%\(lpPctStr.components(separatedBy: ".")[0] + "." + lpPctStr.components(separatedBy: ".")[1].prefix(2))"
        }
        else {
            uniTab_lb1.text = "0 LP"
            uniTab_lb2.text = "%0"
        }
        
        
        if (Double(UserDefaults.standard.object(forKey: "ethBalance") as! Double) >= 0.00001){
            let etherBalanceStr = String(Double(UserDefaults.standard.object(forKey: "ethBalance") as! Double))
            ethTab_lb1.text = toUSDStr(str: etherBalanceStr.components(separatedBy: ".")[0]) + "." + etherBalanceStr.components(separatedBy: ".")[1].prefix(5) + " ETH"
            
            var etherPriceDouble:Double = Double(UserDefaults.standard.object(forKey: "etherPrice") as! Double)
            let etherBalanceUSD:Double = Double(UserDefaults.standard.object(forKey: "ethBalance") as! Double) * etherPriceDouble
            ethTab_lb2.text = "$\(toUSDStr(str: String(etherBalanceUSD).components(separatedBy: ".")[0]) + "." + String(etherBalanceUSD).components(separatedBy: ".")[1].prefix(2))"
        }
        else {
            ethTab_lb1.text = "0 ETH"
            ethTab_lb2.text = "$0"
        }
        
        
        
        
        
    }
    
    
    func copyAddress() {
        
        
        let imageView = UIImageView(frame: CGRect(x: 63, y: 72, width: 230, height: 230))
        imageView.image = UIImage(named: "copyhonk")
        
        
        let start = userWallet.address.index(userWallet.address.startIndex, offsetBy: 0)
        let end = userWallet.address.index(userWallet.address.endIndex, offsetBy: -8)
        let range = start..<end

        let mySubstring = userWallet.address[range] + "..."  // play
        
        

        let alertController = UIAlertController(title: "My $HONK Address", message: mySubstring + "\n \n \n \n \n \n \n \n \n \n \n \n \n \n", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Copy Address", style: .default) { (action) in

            let pasteboard = UIPasteboard.general
            pasteboard.string = self.userWallet.address
            
        }
        
        let action2 = UIAlertAction(title: "action2", style: .default) { (action) in

            self.viewDidLoad()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(action1)
        //alertController.addAction(action2)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        alertController.view.addSubview(imageView)

            
        
    }
    
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
    
    @objc func checkActionHongTab(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.honkTab)
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Deposit HONK", style: .default) { (action) in

                self.copyAddress()
                
            }
            
            let action2 = UIAlertAction(title: "Withdraw HONK", style: .default) { (action) in

                //
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func checkActionLolTab(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.lolTab)
    }
    
    @objc func checkActionUniTab(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.uniTab)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Farm Honk", style: .default) { (action) in

                if let url = URL(string: "tg://resolve?domain=honkfarmbot") {
                    UIApplication.shared.open(url)
                }
                
            }

            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
    }
    
    @objc func checkActionEthTab(sender : UITapGestureRecognizer) {
        // Do what you want
        print("checkAction")
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.ethTab)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Deposit ETH", style: .default) { (action) in

                self.copyAddress()
                
            }
            
            let action2 = UIAlertAction(title: "Withdraw ETH", style: .default) { (action) in

                //
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
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
