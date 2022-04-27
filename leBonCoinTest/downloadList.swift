//
//  downloadList.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 15/04/2022.
//

import Foundation
import SwiftUI
import UIKit

public class downLoadList {
    var chargerObjet: [objetVente] = []
    var copieObjet: [objetVente] = []
    var dateConverti = ""
    
struct objetVente: Identifiable, Codable {
    
    let id: Int
    let title: String
    let category_id: Int
    let description: String
    let price: Float
    let is_urgent: Bool
    let images_url:[String:String]?
    let creation_date: String?
    
}
    
   



func loadList() {
    
    print("loadList")
    guard let listObjetUrl = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }
    let urlSession = URLSession.shared
    var request = URLRequest(url: listObjetUrl)
    request.httpMethod = "GET"
    let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
        guard error == nil,
              let httpResponse = response as? HTTPURLResponse,
              let objetListJsonData = data else {
            return
        }
        print("\(objetListJsonData)")
        
        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            print("no error")
            if let dowloadList = try? JSONDecoder().decode([objetVente].self, from: objetListJsonData) {
                DispatchQueue.main.async {
                    self.chargerObjet = dowloadList
                    self.copieObjet = dowloadList
                
                    self.classementListe()
                  
                }
            }
            
            
        }
    }
    dataTask.resume()
}
    
    
    
    func classementListe() {
        
        chargerObjet.sort { $1.creation_date?.compare($0.creation_date ?? "") == .orderedAscending }
        chargerObjet.sort { $0.is_urgent && !$1.is_urgent }
       
       
        }
    
   
    
  
    
   
    
    
    
   
    
    
    func convertionDate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX")
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          let day = dateFormatter.date(from:date)!
        
        let formatDate = DateFormatter()
          formatDate.dateFormat = "dd/MM/yyyy HH:mm"
          dateConverti = formatDate.string(from: day)
       
        
        return dateConverti
        
        
    }
    
    
    }

    

