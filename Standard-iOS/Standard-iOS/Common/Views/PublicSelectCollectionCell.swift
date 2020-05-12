//
//  ProvideStandardCollectionCell.swift
//  Standard-iOS
//
//  Created by James on 2019/11/17.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit

class PublicSelectCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addLayerShadow()
    }
    
    func refreshSubviews(with title: String?) {
        self.titleLabel.text = title.value()
    }
    
    func setSelectState(_ isSelected: Bool) {
        let selected: String = "system_item_selected"
        let unselect: String = "system_item_unselect"
        let path = isSelected ? selected : unselect
        self.imageView.image = UIImage(named: path)
    }
    
    // FIXME: 这种方式有问题, 需要优化!
    func refreshSubviews(with selected: Bool?) {
        self.setSelectState(selected ?? false)
    }
    
    override var isSelected: Bool {
        didSet {
            self.setSelectState(isSelected)
        }
    }
}
