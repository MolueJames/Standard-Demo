//
//  AggregationInfoReusableView.swift
//  Standard-iOS
//
//  Created by James on 2019/3/9.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit

class PublicTitleReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = CommonColor.appDefault
    }
    
    func refreshSubviews(with title: String) {
        self.titleLabel.text = title
    }
}
