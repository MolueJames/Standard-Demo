//
//  RiskDefaultTableViewCell.swift
//  Standard-iOS
//
//  Created by James on 2019/5/22.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit

class PublicTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func refreshSubviews(with name: String) {
        self.nameLabel.text = name
    }
}
