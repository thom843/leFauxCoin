//
//  trierCategorie.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 19/04/2022.
//

import Foundation
import SwiftUI
import UIKit

class trierCategorie {
    
   
    var chargerCategorie: [categorie] = []
    
    
    struct categorie: Identifiable, Codable {
        let id: Int
        let name: String
    }
    
    
    func loadList() {
        
        print("loadList")
        guard let listObjetUrl = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else { return }
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
                if let dowloadList = try? JSONDecoder().decode([categorie].self, from: objetListJsonData) {
                    DispatchQueue.main.async {
                        self.chargerCategorie = dowloadList
                        
                    
                        self.classementListe()
                       
                       
                    }
                }
                
                
            }
        }
        dataTask.resume()
    }
        
    func classementListe() {
        chargerCategorie.append(categorie(id: 0, name: "TOUT"))
        chargerCategorie.sort { ($0.id == 0) && ($1.id != 0) }
        
        }
    
  
    

    
    
    func nomCategorie(id: Int) -> String {
        if id <= chargerCategorie.count {
        let name = chargerCategorie[id].name
            return name
        } else {
            let name = ""
            return name
        }
        
    }
    
    func categorieList() -> [String] {
        var list: [String] = []
        
        for nameCategorie in chargerCategorie {
            list.append(nameCategorie.name)
            print(nameCategorie.name)
        }
        return list
    }
        
        
       
    
}
