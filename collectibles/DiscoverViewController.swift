//
//  DiscoverViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 11.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

struct Item {
  var imageName: String
}

class DiscoverViewController: UIViewController, CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: items[indexPath.item].imageName)!.size
    }
    
    var items: [Item] = [Item(imageName: "1"),
                         Item(imageName: "2"),
                         Item(imageName: "3"),
                         Item(imageName: "4"),
                         Item(imageName: "5"),
                         Item(imageName: "6"),
                         Item(imageName: "7"),
                         Item(imageName: "8"),
                         Item(imageName: "9"),
                         Item(imageName: "10"),
                         Item(imageName: "11"),
                         Item(imageName: "12")]
    
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    var discoverCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    private func setupCollectionViewItemSize(){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        discoverCollectionView.collectionViewLayout = customLayout
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Discover"
        
        
        discoverCollectionView.register(UINib(nibName: "discoverCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "discoverCollectionViewCell")
        discoverCollectionView.reloadData()
        


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

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell!
        
        cell = discoverCollectionView.dequeueReusableCell(withReuseIdentifier: "discoverCollectionViewCell", for: indexPath) as! discoverCollectionViewCell
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedModel = indexPath.row
        //addCredentialButton.isHidden = true
        //performSegue(withIdentifier: "viewNFTDetails", sender: self)
    }
    
    
}


