//
//  ViewController.swift
//  MovieApp
//
//  Created by Ganesh on 23/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
            self.performSegue(withIdentifier: "jumptohome", sender: nil)
        })
    }


}

