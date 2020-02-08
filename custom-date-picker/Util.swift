//
//  Util.swift
//  custom-date-picker
//
//  Created by Alejandra Wetsch on 2/8/20.
//  Copyright © 2020 mawr. All rights reserved.
//

import Foundation

class Util{
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

