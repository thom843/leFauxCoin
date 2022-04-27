//
//  customTableViewCell.swift
//  leBonCoinTest
//
//  Created by Thomas Habib on 18/04/2022.
//

import UIKit

class customTableViewCell: UITableViewCell {
    @IBOutlet weak var urgentCellule: UILabel!
    @IBOutlet weak var imageCellule: UIImageView!
    @IBOutlet weak var nomObjetCellule: UILabel!
    @IBOutlet weak var categorieCellule: UILabel!
    @IBOutlet weak var prixCellule: UILabel!
    @IBOutlet weak var dateCellule: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
