//
//  MovieVO.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/03/30.
//

import Foundation
import UIKit

class MovieVO {
    var thumbnail: String? //썸네일 이미지 주소
    var title : String? // 영화 제목
    var description: String? // 영화 정보
    var detail : String? // 영화 상새설명
    var opendate : String? // 영화 개봉일
    var rating : Double? // 영화 평점
    // 영화 썸네일 이미지를 담을 UIImage 객체를 추가한다.
    var thumbnailImage: UIImage?
}


