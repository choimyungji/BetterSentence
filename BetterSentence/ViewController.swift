//
//  ViewController.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sentenceLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sentence = exampleSentence
        sentenceLabel.text = sentence.sentence
        authorLabel.text = sentence.author
    }


}

