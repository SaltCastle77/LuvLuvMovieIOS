//
//  TheaterListController.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/04/11.
//

import UIKit
class TheaterListController: UITableViewController {
    // API를 통해 불러온 데이터를 저장할 배열 변수를 찾는다.
    var list = [NSDictionary]()
    // 읽어올 데이터의 시작 위치
    var startPoint = 0
    
    override func viewDidLoad() {
        // API호출은 여기서 이뤄줘야한다. 데이터를 가져와야한다.
        callTheaterAPI()
    }
    // 극장 API를 가져올 API 호출 함수
    func callTheaterAPI(){
        // URL을 구성하기 위한 상수값을 선언한다.
        let request = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = 100
        let type = "json" // 데이터 형식
        
        // URL객체로 정해준다 왜? 요청을 보낼꺼면 URL객체로 저장해줘야하기때문이다!
        let urlObj = URL(string: "\(request)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        // 이제 이걸 호출에 넣어야겠지? 근대 살짝 다르다.
        do {
            // NSString 객체를 이용해서 API를 호출한다. 원래 Data(contentesOf)롤 객체를 통해서 가져왔지만
            // 여기서는 NSString객체를 이용하한다. 왜냐? 영화관 데이터가 UTF-8이 아니라 EUC-KR이기 떄문에 NSString은
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            // 문자열로 받은 데이터를 UTF-8로 인코딩 처리한 Data 객체로 변환한다. -> 담은 NSArray 객체로 변환해지?
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
                do {
                    //Data 객체를 파싱해서 NSArray 객체로 변환다.
                    let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                    
                    // 읽어온 데이터를 순회하면서 self.list 배열에 추가한다. jsonObject 메서드의 리턴 값이 nil이거나 jaonData이기 떄문에 apiArray에 !를 붙여서 옵셔널 추출을 실행한다.
                    for obj in apiArray! {
                        self.list.append(obj as! NSDictionary)
                    }
                } catch {
                    // 경고창 형식으로 오류 메세지를 표시해준다.
                    let alert = UIAlertController(title: "실패", message: "데이터 분석이 실패하였습니다.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title:"확인", style: .cancel))
                    self.present(alert, animated: false)
                }
            // 읽어와야할 다음 페이지의 데이터 시작 위치를 구해서 저장한다.
            self.startPoint += sList
            } catch {
                // 경고창 형식으로 오류 메세지를 표시해준다.
                let alert = UIAlertController(title: "실패", message: "데이터 분석이 실패하였습니다.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title:"확인", style: .cancel))
                self.present(alert, animated: false)
            }
        }
        // 위의 코드들은 영화관 데이터를 list에 담기위한 로직 이제 테이블 목록을 cell에 나타내줘야한다.그럼 뭘해야해? 관련 메소드를 호출하면되지
    // 1) 셀행의 갯수를 출력한다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    // 2) 셀에 내용을 표기해줘야지.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // sefl.list 배열에서 행에 맞는 데어틀 꺼낸다.
        let obj = list[indexPath.row]
           
        // 재사용 큐로부터 tCell 식별자에 맞는 셀 객체를 전달 받는다. // TheaterCell로 다운캐스팅도한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr.text = obj["소재지도로명주소"] as? String
        
        return cell
    }
    
    }
