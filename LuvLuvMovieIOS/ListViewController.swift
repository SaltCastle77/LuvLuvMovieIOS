//
//  ListViewController.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/03/30.
//

import UIKit

class ListViewController: UITableViewController{
    
    override func viewDidLoad() {
        self.callMovieAPI()
    }
    
    var page = 1
    
    let tmdb_img_url = "https://image.tmdb.org/t/p/w500"
    
    @IBAction func more(_ sender: Any) {
        self.page += 1
        // 영화 차트 API 호출
        self.callMovieAPI()
        // 데이터를 다시 읽어오도록 갱신해야한다.
        self.tableView.reloadData()
    }
    
    @IBOutlet var moreBtn: UIButton!
    
    func callMovieAPI() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=9c16b0e3f97fb175552f5d4ee8d06016&language=ko-KR&page=\(self.page)"
        
        let apiURL: URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURL)
        
//        let log = NSString(data:apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
//
//        NSLog("\(log)")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let movie = apiDictionary["results"] as! NSArray
            
            let totalCount = apiDictionary["total_results"] as! Int
            
            // 전체리스트의 갯수가 API의 저체 갯수보다 많아지면 더보기 버튼을 숨기게 한다.
            if (self.list.count >= totalCount) {
                self.moreBtn.isHidden = true
            }
            
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                mvo.title = r["title"] as? String
                mvo.description = r["overview"] as? String
                mvo.thumbnail = r["poster_path"] as? String
                mvo.detail = r["original_title"] as? String
                mvo.rating = r["vote_average"] as? Double
                mvo.opendate = r["release_date"] as? String
            
                let thumb_img_url = tmdb_img_url + mvo.thumbnail!
                NSLog("\(thumb_img_url)")
                // 썸네일 경로로 인자값으로 하는 URL 객체를 생성
                let img_url : URL! = URL(string: thumb_img_url)
                // 이미지를 긁어와 변수에 저장하고 이를 mvo 인스턴스에 넣는다.
                let imageData = try! Data(contentsOf: img_url)
                mvo.thumbnailImage = UIImage(data: imageData)
                // 배열에 추가
                self.list.append(mvo)
            }
            
        } catch {
            NSLog("Parse Error!!!")
        }
    }
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 생성해야 할 행의 개수를 반환하는 메소드 상위 클래스인 UITableView에 지정되어있어 override해줘야한다.
        return self.list.count // 생성되는 list갯수만큼 리턴 해줘야한다.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 테이블 뷰 의 개별 행 내용을 담는 것
        let row = self.list[indexPath.row] // 행의 번호를 알고 싶을떄 list[indexPath.row]를 사용하면 알 수 있다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell // cell 객체를 생성,
        
        cell.thumbnail.image = row.thumbnailImage //이미지 객체를 넣는다.
        
        cell.title?.text = row.title
        
        cell.desc?.text = row.description
        
        cell.opendate?.text = row.opendate
        
        cell.rating?.text = "\(row.rating!)"
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //테이블 셀을 클릭했을때 실행되는 함수
        NSLog("선택된 행은\(indexPath.row) 번째 행입니다.")
    }
    
    
    
    
}
