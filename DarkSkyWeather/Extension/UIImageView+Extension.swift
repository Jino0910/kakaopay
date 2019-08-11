//
//  UIImageView+Extension.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

typealias imageAsyncType = (iv: UIImageView, image: UIImage?)

extension UIImageView {
    
    func asyncImageLoad(url: URL, handler: @escaping ((_ imageView: UIImageView, _ image: UIImage?) -> Void)) {
        
        let imageCache = NSCache<NSString, UIImage>()
        
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            handler(self, cachedImage)
        }
        else
        {
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                    handler(self, image)
                }
            }
        }
    }
    
    func rx_asyncImageLoad(url: URL) -> PrimitiveSequence<SingleTrait, imageAsyncType> {
        
        return Single.create(subscribe: { (single) -> Disposable in
            
            let imageCache = NSCache<NSString, UIImage>()
            
            if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
                single(.success((self, cachedImage)))
            }
            else
            {
                DispatchQueue.global(qos: .background).async {
                    guard let data = try? Data(contentsOf: url) else { return }
                    guard let image = UIImage(data: data) else { return  }
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                        single(.success((self, image)))
                    }
                }
            }
            
            return Disposables.create {}
        })
    }
}
