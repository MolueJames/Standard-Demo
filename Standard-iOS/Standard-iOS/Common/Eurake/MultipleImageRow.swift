//
//  ImageRow.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/18.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit
import Gallery
import Eureka

class MultipleImageCell: Cell<[FileAttachment]>, CellType {
    
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let name = UINotification.orientationDidChaned.toName()
        let selector: Selector = #selector(didChangeOrientation)
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func didChangeOrientation(_ notification: NSNotification) {
        self.collectionView.snp.updateConstraints { (make) in
            let viewHeight = self.itemSize.height + 11
            make.height.equalTo(viewHeight)
        }
        self.flowLayout.itemSize = self.itemSize
        self.height = { [unowned self] in
             self.itemSize.height + 55
        }
    }
    
    private weak var photoController: GalleryController?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.register(nibWithCellClass: DisplayImageCollectionCell.self)
        collectionView.register(nibWithCellClass: AppendImageCollectionCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        flowLayout.itemSize = self.itemSize
        return flowLayout
    }()
    
    private var itemSize: CGSize {
        var width = (AppConfigure.ScreenWidth - 40 - 75) / 6
        if SceneManager.shared.isPortrait && AppConfigure.isPad {
            width = (AppConfigure.ScreenWidth - 40 - 60) / 5
        } else if AppConfigure.isPhone {
            width = (AppConfigure.ScreenWidth - 30 - 30) / 3
        }
        return CGSize(width: width, height: width)
    }
    
    lazy var imageAttachments: [FileAttachment] = {
        if let value = self.row.value {
            return value
        }
        return [FileAttachment]()
    }()
    
    public var maxImageCount: Int = 4
    
    override func setup() {
        super.setup()
        self.collectionView.snp.updateConstraints { (make) in
            let viewHeight = self.itemSize.height + 11
            make.height.equalTo(viewHeight)
        }
        
        self.collectionView.snp.makeConstraints { [unowned self] (make) in
            do {
                let label = try self.textLabel.unwrap()
                make.right.equalTo(label.snp_right)
                make.left.equalTo(label.snp_left)
            } catch {
                Logger.surface.message(error)
            }
            make.bottom.equalToSuperview()
        }
        
        self.height = { [unowned self] in
            self.itemSize.height + 55
        }
        self.detailTextLabel?.isHidden = true
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let left = self.textLabel?.originX ?? 0
        let width = AppConfigure.ScreenWidth
        self.textLabel?.width = width - 2 * left
        self.textLabel?.originY = 0
        self.textLabel?.height = 45
    }
}

extension MultipleImageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let imageCount: Int = self.imageAttachments.count
        let isFull: Bool = imageCount >= maxImageCount
        return isFull ? maxImageCount : imageCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.imageAttachments.count {
            let cell = collectionView.dequeueReusableCell(withClass: DisplayImageCollectionCell.self, for: indexPath)
            do {
                let item = self.imageAttachments.item(at: indexPath.row)
                try cell.refreshSubviews(with: item.unwrap())
            } catch {
                Logger.surface.message(error)
            }
            return cell
        }
        return collectionView.dequeueReusableCell(withClass: AppendImageCollectionCell.self, for: indexPath)
    }
}

extension MultipleImageCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row < self.imageAttachments.count) {
            self.jumpToBrowserController(with: indexPath.row)
        } else {
            self.jumpToTakePhotoController()
        }
    }
    
    func jumpToBrowserController(with index: Int) {
        let photoImages:[KFPhoto] = self.imageAttachments.compactMap { [unowned self] attachment in
            return self.createKFPhoto(with: attachment)
        }
        self.pushToBrowser(with: photoImages, index: index)
    }
    
    func pushToBrowser(with photos: [SKPhotoProtocol], index: Int) {
        let browser = SKPhotoBrowser(photos: photos)
        browser.initializePageIndex(index)
        browser.delegate = self
        PageNavigator.shared.presentViewController(browser)
    }
    
    func createKFPhoto(with attachment: FileAttachment) -> KFPhoto? {
        if let urlPath = attachment.url {
            return KFPhoto(url: urlPath)
        }
        if let image = attachment.image {
            return KFPhoto(image: image)
        }
        return Logger.surface.allowNil("")
    }
    
    func jumpToTakePhotoController() {
        let controller = GalleryController()
        controller.modalPresentationStyle = .fullScreen
        Config.tabsToShow = [.cameraTab, .imageTab]
        let current = self.imageAttachments.count
        let limit = self.maxImageCount - current
        Config.Camera.imageLimit = limit
        controller.delegate = self
        PageNavigator.shared.presentViewController(controller)
    }
}

extension MultipleImageCell: SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        defer { reload() }
        self.removePhoto(from: self.photoController, index: index)
        self.removeAttachments(with: index)
    }
    
    func removePhoto(from controller: GalleryController?, index: Int) {
        do {
            let photoController = try controller.unwrap()
            var images = photoController.cart.images
            let image = images.remove(at: index)
            photoController.cart.remove(image)
            photoController.cart.reload(images)
        } catch {
            Logger.surface.message(error)
        }
    }
}

extension MultipleImageCell: GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        Image.resolve(images: images) { [weak self] images in
            do {
                let attachments: [FileAttachment] = images.compactMap({ image in
                    return FileAttachment(image)
                })
                try self.unwrap().updateAttachments(with: attachments)
            } catch {
                Logger.surface.error(error)
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func removeAttachments(with index: Int) {
        if self.imageAttachments.count > index {
            self.imageAttachments.remove(at: index)
            self.row.value = self.imageAttachments
            self.collectionView.reloadData()
        }
    }
    
    private func updateAttachments(with attachments: [FileAttachment]) {
        self.imageAttachments.append(contentsOf: attachments)
        self.row.value = self.imageAttachments
        self.collectionView.reloadData()
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        Image.resolve(images: images) { [weak self] resolvedImages in
            guard resolvedImages.count > 0 else {return}
            do {
                let images = resolvedImages.compactMap({$0})
                let photoImages:[SKPhoto] = images.map {
                    SKPhoto.photoWithImage($0)
                }
                try self.unwrap().pushToBrowser(with: photoImages, index: 0)
            } catch {
                Logger.surface.error(error)
            }
        }
        self.photoController = controller
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

final class MultipleImageRow: Row<MultipleImageCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MultipleImageCell>()
    }
    
    public func updateInterface() {
        self.cell.collectionView.reloadData()
    }
}
