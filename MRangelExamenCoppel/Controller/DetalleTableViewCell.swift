//
//  DetalleTableViewCell.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 07/02/23.
//

import UIKit

class DetalleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImagenMovie: UIImageView!
    @IBOutlet weak var TituloLbl: UILabel!
    @IBOutlet weak var FechaEstrenoLbl: UILabel!
    @IBOutlet weak var PuntosLbl: UILabel!
    @IBOutlet weak var LenguaLbl: UILabel!
    @IBOutlet weak var DescripcionLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
