//
//  ViewController.swift
//  StarRating
//
//  Created by scott harris on 2/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateRating(_ ratingControl: StarRatingControl) {
        let rating = ratingControl.value
        title = "User Rating: \(rating) stars"
    }
    
}

