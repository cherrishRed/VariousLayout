//
//  BasicCell.swift
//  VariousLayouts
//
//  Created by 박세리 on 2023/06/02.
//

import UIKit

class BasicCell: UICollectionViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var view: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.backgroundColor = .white
    view.layer.cornerRadius = 4
    // Initialization code
  }
}
