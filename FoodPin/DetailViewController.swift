//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 20.06.2015.
//  Copyright (c) 2015 Kamil Kowalski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var restaurantImageView:UIImageView!
    var restaurantImage:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.restaurantImageView.image = UIImage(named: restaurantImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
