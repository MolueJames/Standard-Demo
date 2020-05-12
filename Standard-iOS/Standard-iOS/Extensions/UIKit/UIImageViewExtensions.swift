//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit
import Kingfisher

// MARK: - Methods
public extension UIImageView {
	
	/// SwifterSwift: Set image from a URL.
	///
	/// - Parameters:
	///   - url: URL of image.
	///   - contentMode: imageView content mode (default is .scaleAspectFit).
	///   - placeHolder: optional placeholder image
	///   - completionHandler: optional completion handler to run when download finishs (default is nil).
	func download(
		from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
		placeholder: UIImage? = nil,
		completionHandler: ((UIImage?) -> Void)? = nil) {
		
		image = placeholder
		self.contentMode = contentMode
		URLSession.shared.dataTask(with: url) { (data, response, _) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data,
				let image = UIImage(data: data)
				else {
					completionHandler?(nil)
					return
			}
			DispatchQueue.main.async {
				self.image = image
				completionHandler?(image)
			}
			}.resume()
	}
	
	/// SwifterSwift: Make image view blurry
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
		let blurEffect = UIBlurEffect(style: style)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		addSubview(blurEffectView)
		clipsToBounds = true
	}
	
	/// SwifterSwift: Blurred version of an image view
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	/// - Returns: blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
		let imgView = self
		imgView.blur(withStyle: style)
		return imgView
	}
}

extension Kingfisher where Base: UIImageView {
    func setImage(with urlPath: String) {
        let modifier: AnyModifier = self.queryRequestAnyModifier()
        let options: KingfisherOptionsInfo = [.requestModifier(modifier)]
        self.setImage(with: URL(string: urlPath), options: options)
    }
    
    private func queryRequestAnyModifier () -> AnyModifier {
        return AnyModifier { request in
            var urlRequest: URLRequest = request
            let token = "UserLoginEntity.queryCurrent()?.token"
            urlRequest.setValue(token, forHTTPHeaderField: "token")
            return urlRequest
        }
    }
}
#endif
