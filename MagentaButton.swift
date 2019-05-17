//
//  RedButton.swift
//  Pila
//
//  Created by Dev2 on 08/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class MagentaButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        backgroundColor = UIColor.magenta
        layer.cornerRadius = 10
        layer.borderColor = UIColor.yellow.cgColor
        layer.borderWidth = 1.0
        setTitleColor(.yellow, for: .normal)
    }


}
