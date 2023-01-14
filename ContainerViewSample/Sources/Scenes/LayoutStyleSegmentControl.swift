//
//  LayoutStyleSegmentControl.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2022/12/31.
//

import UIKit

class LayoutStyleSegmentControl: UISegmentedControl {

    var style: Style {
        switch self.selectedSegmentIndex{
        case 0:
            return .table
        case 1:
            return .grid
        default:
            preconditionFailure("unknown case")
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension LayoutStyleSegmentControl {

    enum Style {
        case table
        case grid
    }
}
