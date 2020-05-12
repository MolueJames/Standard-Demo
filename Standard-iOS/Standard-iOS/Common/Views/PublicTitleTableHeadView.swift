//
//  TitleTableHeader.swift
//  Standard-iOS
//
//  Created by James on 2019/5/22.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit

class PublicTitleTableHeadView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var nameLabel: UILabel!
    
    func refreshSubviews(with name: String) {
        self.nameLabel.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: 0xc9c9ce)
    }
}
