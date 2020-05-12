//
//  MultipleItemTableViewCell.swift
//  Standard-iOS
//
//  Created by MolueJames on 2020/4/4.
//  Copyright © 2020 YunZhou. All rights reserved.
//

import UIKit

class MultipleItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        let color = UIColor(hex: 0x333333).cgColor
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshSubviews(with title: String) {
        self.titleLabel.text = title
    }
    
    override var frame: CGRect {
        didSet {
            var new: CGRect = self.frame
            let originX = AppConfigure.isPad ? 15 : 20
            new.size.width -= CGFloat(originX * 2)
            new.origin.x += CGFloat(originX)
            new.size.height -= 10
            new.origin.y += 5
            super.frame = new
        }
    }
}
