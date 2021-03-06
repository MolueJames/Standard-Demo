//
//  KFPhoto.swift
//  SKPhotoBrowser-Kingfisher
//
//  Created by Will on 2018/5/28.
//  Copyright © 2018 Will. All rights reserved.
//

import UIKit
import Kingfisher

open class KFPhoto: NSObject, SKPhotoProtocol {

    // MARK: - SKPhotoProtocol
    open var index: Int = 0
    open var underlyingImage: UIImage!
    open var caption: String?
    open var contentMode: UIView.ContentMode = .scaleAspectFill

    open var shouldCachePhotoURLImage: Bool = true
    open var photoURL: String!

    // MARK: - init
    public override init() {
        super.init()
    }

    public convenience init(image: UIImage) {
        self.init()
        underlyingImage = image
    }

    public convenience init(url: String) {
        self.init()
        photoURL = url
    }

    public convenience init(url: String, holder: UIImage?) {
        self.init()
        photoURL = url
        underlyingImage = holder
    }

    // MARK: - SKPhotoProtocol
    open func checkCache() {
        guard let photoURL = photoURL else {
            return
        }
        guard shouldCachePhotoURLImage else {
            return
        }

        if ImageCache.default.imageCachedType(forKey: photoURL).cached == true {
            underlyingImage = ImageCache.default.retrieveImageInDiskCache(forKey: photoURL)
        }
    }

    open func loadUnderlyingImageAndNotify() {
        guard photoURL != nil, let URL = URL(string: photoURL) else { return }

        // Fetch Image
        ImageDownloader.default.downloadImage(with: URL, options: [], progressBlock: nil) { (image, error, url, data) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.loadUnderlyingImageComplete()
                }
                return
            }

            if let image = image {
                if self.shouldCachePhotoURLImage {
                    ImageCache.default.store(image, original: data, forKey: self.photoURL, toDisk: true)
                }
                DispatchQueue.main.async {
                    self.loadUnderlyingImageComplete()
                }
                return
            }
        }
    }

    open func loadUnderlyingImageComplete() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: SKPHOTO_LOADING_DID_END_NOTIFICATION), object: self)
    }
}
