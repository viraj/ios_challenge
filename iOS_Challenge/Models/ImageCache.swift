//
//  ImageCache.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit



class ImageCache {
    static func storeImage(urlString: String, userId: String, image: UIImage) {
        
        let imagePath = NSTemporaryDirectory().appending("\(userId).jpg")
        let url = URL(fileURLWithPath: imagePath)
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        try? imageData?.write(to: url)
    }
    
    static func loadImage(urlString: String, userId: String, completion : @escaping ( String, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let imagePath = NSTemporaryDirectory().appending("\(userId).jpg")
        if let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) {
            let image = UIImage(data: imageData)
            completion(urlString, image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            guard let d = data else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: d) {
                    storeImage(urlString: urlString, userId: userId, image: image)
                    completion(urlString, image)
                }
            }
        }
        task.resume()
    }
}
