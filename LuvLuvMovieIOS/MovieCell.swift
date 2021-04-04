//
//  MovieCell.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/04/01.
//

import UIKit

class MovieCell: UITableViewCell { //테이블 뷰 셀을 위한것
    @IBOutlet var title: UILabel!
    
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var opendate: UILabel!
    
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
}
