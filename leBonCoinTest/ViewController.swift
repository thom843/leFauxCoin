//
//  ViewController.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 15/04/2022.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    private func registerTableViewCells() {
    let textFieldCell = UINib(nibName: "customTableViewCell", bundle: nil)
    self.tableViewObjet.register(textFieldCell, forCellReuseIdentifier: "cellule")
    }
    
    
    @IBOutlet weak var tableViewObjet: UITableView!
    @IBOutlet weak var tableViewCategorie: UITableView!
    var height = NSLayoutConstraint()

    
    
    
    
    
    let chargerList = downLoadList()
    let chargerImage = downloadImage()
    let chargerCategorie = leBonCoinTest.trierCategorie()
    
    var rowSelection = 1
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewObjet.delegate = self
        tableViewObjet.dataSource = self
        tableViewCategorie.delegate = self
        tableViewCategorie.dataSource = self
        buttonSetting()
        height = tableViewCategorie.heightAnchor.constraint(equalToConstant: 0)
        self.registerTableViewCells()
        dissmissDropDown()
        
        chargerCategorie.loadList()
        chargerList.loadList()
        
        
        
        delayWithSeconds(1.5) {
            self.tableViewObjet.reloadData()
            self.tableViewCategorie.reloadData()
           
        }
       
    }
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewObjet {
        print("caseSelectionné\(indexPath.row)")
        rowSelection = indexPath.row
        performSegue(withIdentifier: "detail", sender: nil)
        } else {
            
                self.trierLesCategories(idChoix: indexPath.row)
            
            settingCategorieButton.setTitle(chargerCategorie.categorieList()[indexPath.row], for: .normal)
            dissmissDropDown()
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == tableViewObjet {
        print("nombre: \(chargerList.chargerObjet.count)")
            count = chargerList.chargerObjet.count
        } else {
            count = chargerCategorie.chargerCategorie.count
        }
        return count
        
    
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        if tableView == tableViewObjet {
        let objet = chargerList.chargerObjet[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellule", for: indexPath) as! customTableViewCell
            
            DispatchQueue.main.async() {
                let image = objet.images_url!["small"] ?? ""
                self.chargerImage.downloadImage(from: image)
                cell.imageCellule.downloaded(from: image)
            }
            cell.nomObjetCellule.text = objet.title
            cell.prixCellule.text = "\(Int(objet.price))€"
            cell.urgentCellule.text = ""
            
                if objet.is_urgent == true {
                cell.urgentCellule.text = "Urgent"
            }
            cell.contentView.backgroundColor = .white
            if indexPath.row % 2 == 0 {
                cell.contentView.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 225/255, alpha: 1)
            }
                
                cell.categorieCellule.text = "\(self.chargerCategorie.nomCategorie(id: objet.category_id))"
                cell.dateCellule.text = "Mis en ligne le \(self.chargerList.convertionDate(date: objet.creation_date ?? ""))"
            
            return cell
            
        
        
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = chargerCategorie.categorieList()[indexPath.row]
            cell.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1)
            cell.layer.cornerRadius = 12
            return cell
        }
           
           }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tableViewObjet {
            cell.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
   }
    
    
    
    
  
    
    
    var isOpen = false
    @IBOutlet weak var settingCategorieButton: UIButton!
    @IBAction func categorieButton(_ sender: Any) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            
            if tableViewCategorie.contentSize.height > 400 {
                self.height.constant = 400
            } else {
                self.height.constant = tableViewCategorie.contentSize.height
            }
            
            
            self.height.constant = 400
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.tableViewCategorie.layoutIfNeeded()
                self.tableViewCategorie.center.y += self.tableViewCategorie.frame.height / 2
            }, completion: nil)
        } else {
            self.dissmissDropDown()
    }
    }
    
    
    
        func dissmissDropDown() {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.tableViewCategorie.center.y -= self.tableViewCategorie.frame.height / 2
                self.tableViewCategorie.layoutIfNeeded()
            }, completion: nil)
        }
    
    
    
    
    

    
        func trierLesCategories(idChoix: Int) {
            
            let listeComplete = chargerList.copieObjet
        chargerList.chargerObjet = listeComplete
        let objetCategorie = chargerList.chargerObjet.filter {$0.category_id == idChoix}
        chargerList.chargerObjet = objetCategorie
           
        if idChoix == 0 {
            chargerList.chargerObjet = listeComplete
        }
            chargerList.classementListe()
            tableViewObjet?.reloadData()
    }
    
    
    
    
   
    
    func buttonSetting() {
        settingCategorieButton.layer.cornerRadius = 12
        tableViewCategorie.layer.cornerRadius = 12
        tableViewCategorie.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
    }
    
  
    
    
  
    @IBOutlet weak var buttonReload: UIButton!
    @IBAction func reloadButton(_ sender: Any) {
        chargerList.loadList()
        tableViewObjet.reloadData()
    }
    
   
    

    
        func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    

    
    
 
    @IBAction func retourPageAccueil(segue:UIStoryboardSegue) {
        
    }
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let info = segue.destination as! showDetailObjectViewController
            print(rowSelection)
            info.objet = chargerList.chargerObjet
            info.objetSelectionRow = rowSelection
           
            
        }
    }
    
    
    
    


}

