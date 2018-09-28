//
//  MapTableViewCell.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 28/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet var pinImage: UIImageView!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var mediaURL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureStudentLocationCell(student: UdacityStudentInformation) {
        
        fullName.text = student.FirstName
        mediaURL.text = student.MediaURL
    }

}
