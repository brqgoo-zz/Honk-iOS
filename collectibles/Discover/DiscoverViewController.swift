//Created by Real Life Swift on 22/12/2018

import UIKit

struct Item {
  var imageName: String
}

class DiscoverViewController: UIViewController {

  enum Mode {
    case view
    case select
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var items: [Item] = [Item(imageName: "1"),
                       Item(imageName: "2"),
                       Item(imageName: "3"),
                       Item(imageName: "4"),
                       Item(imageName: "5"),
                       Item(imageName: "6"),
                       Item(imageName: "7"),
                       Item(imageName: "8")]
    
    var itemsStrs: [String] = ["NFT #90132",
                         "NFT #92340",
                         "NFT #23984",
                         "NFT #01209",
                         "NFT #48234",
                         "NFT #58912",
                         "NFT #79123",
                         "NFT #99132"]
  
  var collectionViewFlowLayout: UICollectionViewFlowLayout!
  let cellIdentifier = "ItemCollectionViewCell"
  let viewImageSegueIdentifier = "viewImageSegueIdentifier"
  
  var mMode: Mode = .view {
    didSet {
      switch mMode {
      case .view:
        for (key, value) in dictionarySelectedIndecPath {
          if value {
            collectionView.deselectItem(at: key, animated: true)
          }
        }
        
        dictionarySelectedIndecPath.removeAll()
        
        selectBarButton.title = "Select"
        navigationItem.leftBarButtonItem = nil
        collectionView.allowsMultipleSelection = false
      case .select:
        selectBarButton.title = "Cancel"
        navigationItem.leftBarButtonItem = deleteBarButton
        collectionView.allowsMultipleSelection = true
      }
    }
  }
  
  lazy var selectBarButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
    return barButtonItem
  }()

  lazy var deleteBarButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
    return barButtonItem
  }()
  
  var dictionarySelectedIndecPath: [IndexPath: Bool] = [:]
  
  let lineSpacing: CGFloat = 5
  let interItemSpacing: CGFloat = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Discover"
    // Do any additional setup after loading the view, typically from a nib.
    setupBarButtonItems()
    setupCollectionView()
    setupCollectionViewItemSize()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let item = sender as! Item
    
    if segue.identifier == viewImageSegueIdentifier {
      if let vc = segue.destination as? ImageViewerViewController {
        vc.imageName = item.imageName
      }
    }
  }
  
  private func setupBarButtonItems() {
    navigationItem.rightBarButtonItem = selectBarButton
  }

  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
  }
  
  private func setupCollectionViewItemSize() {
    let customLayout = CustomLayout()
    customLayout.delegate = self
    collectionView.collectionViewLayout = customLayout
  }
  
  @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
    mMode = mMode == .view ? .select : .view
  }
  
  @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
    var deleteNeededIndexPaths: [IndexPath] = []
    for (key, value) in dictionarySelectedIndecPath {
      if value {
        deleteNeededIndexPaths.append(key)
      }
    }
    
    for i in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
      items.remove(at: i.item)
    }
    
    collectionView.deleteItems(at: deleteNeededIndexPaths)
    dictionarySelectedIndecPath.removeAll()
  }
  
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
    cell.mainTitle.text = itemsStrs[indexPath.item]
    cell.imageView.image = UIImage(named: items[indexPath.item].imageName)
    
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
    impactFeedbackgenerator.prepare()
    impactFeedbackgenerator.impactOccurred()
    
    animateCollectionViewCell(sender: collectionView.cellForItem(at: indexPath)!)
    
  }

    func animateCollectionViewCell(sender: UICollectionViewCell) {
       
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

extension DiscoverViewController: CustomLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
    return UIImage(named: items[indexPath.item].imageName)!.size
  }
}

