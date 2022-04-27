//
//  showDetailObjectViewController.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 20/04/2022.
//

import UIKit

class showDetailObjectViewController: UIViewController {

    @IBOutlet weak var imageObjet: UIImageView!
    @IBOutlet weak var nomObjet: UILabel!
    @IBOutlet weak var prixObjet: UILabel!
    @IBOutlet weak var detailObjet: UITextView!
    
    @IBOutlet weak var retourButton: UIButton!
    
    
    var objetSelectionRow = 0
    let list = downLoadList()
    let chargerImage = downloadImage()
    var objet: [downLoadList.objetVente] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(objetSelectionRow)
        let objet = objet[objetSelectionRow]
        retourButton.layer.cornerRadius = 12
        nomObjet.text = objet.title
        prixObjet.text = "\(Int(objet.price))€"
        detailObjet.text = objet.description
        let image = objet.images_url!["thumb"] ?? ""
        self.chargerImage.downloadImage(from: image)
        imageObjet.downloaded(from: image)
        view.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 225/255, alpha: 1)
        
        


    }
    

   

}
