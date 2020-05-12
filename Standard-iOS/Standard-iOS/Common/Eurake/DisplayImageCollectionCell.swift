//
//  DisplayImageCollectionCell.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/18.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit

class DisplayImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addLayerShadow()
    }

    func refreshSubviews(with attachment: FileAttachment) {
        if let path = attachment.url {
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(with: path)
        } else if let image = attachment.image {
            self.imageView.image = image
        }
    }
}
