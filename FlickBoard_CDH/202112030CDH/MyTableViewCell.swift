//
//  MyTableViewCell.swift
//  MovieCDH
//
//  Created by Induk CS on 2025/05/07.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var audiAccumulate: UILabel!
    @IBOutlet weak var audiCount: UILabel!
    
    override func awakeFromNib() { // 현재 필요없음
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { // 현재 필요없음
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
