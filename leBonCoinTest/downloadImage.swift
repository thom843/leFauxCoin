//
//  downloadImage.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 19/04/2022.
//

import Foundation
import UIKit



class downloadImage {

    var imageDownload = UIImage(named: "image-not-found")
  
    
    
   
    
    func downloadImage(from url: String) {
        imageDownload = UIImage(named: "image-not-found")
        print("Download Started")
        if url != "" {
        let Url = URL(string: url)
       
        getData(from: Url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? Url!.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageDownload = UIImage(data: data)
            }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
