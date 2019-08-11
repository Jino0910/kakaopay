//
//  WeatherDescriptionCell.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit

class WeatherDescriptionCell: UITableViewCell {

    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var contentLabel1: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var contentLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: WeatherDescription) {
        self.titleLabel1.text = model.title1
        self.contentLabel1.text = model.content1
        self.titleLabel2.text = model.title2
        self.contentLabel2.text = model.content2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

struct WeatherDescription {
    
    var title1: String = ""
    var content1: String = ""
    var title2: String = ""
    var content2: String = ""
    
    init(title1: String, content1: String, title2: String, content2: String) {
        self.title1 = title1
        self.content1 = content1
        self.title2 = title2
        self.content2 = content2
    }
}
