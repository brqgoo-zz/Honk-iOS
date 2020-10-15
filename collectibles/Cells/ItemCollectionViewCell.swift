//Created by Real Life Swift on 22/12/2018

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var highlightIndicator: UIView!
  @IBOutlet weak var selectIndicator: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceIcon: UIImageView!
    
  
  override var isHighlighted: Bool {
    didSet {
      highlightIndicator.isHidden = !isHighlighted
    }
  }
  
  override var isSelected: Bool {
    didSet {
      highlightIndicator.isHidden = !isSelected
      selectIndicator.isHidden = !isSelected
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    mainView.layer.shadowColor = UIColor.black.cgColor
    mainView.layer.shadowOpacity = 0.02
    mainView.layer.shadowOffset = .zero
    mainView.layer.shadowRadius = 8
    mainView.layer.cornerRadius = 8
    
    priceView.layer.cornerRadius = 11
    
        // Initialization code
    }

}
