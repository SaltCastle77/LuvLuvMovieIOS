//
//  TheaterViewController.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/04/11.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    // 전달 되는 데이터를 받을 변수 영화관 목록이 NSDIctionary 타입으로 되어 있어서 이를 전달 받을 변수 또한 동일한 타입으로 정의되어야한다.
    var param : NSDictionary!
    // 타입이 MKMapView가 된다.
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        // as? : 조건부 다운 캐스팅으로 String타입이 아닐경우 옵셔널타입으로 반환하게된다
        // as! : 강제 다운캐스팅으로 해당 타입이 아닐경우 오류를 발생하지만 반환타입이 일반이라서 활용성이 높을 수 도있다.
        self.navigationItem.title = self.param["상영관명"] as? String
        
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        // 2. 위도와 경도를 인수로 하는 2D 위치 정보 객체를 정의힌다.
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        // 3. 맵에 표현될 지역의 너비를 설정한다. 1:100의 비율 즉, 추ㄱ척 값을 나타낸다.
        let regionRadius: CLLocationDistance = 100
        // 4. 거리를 반영한 지역 정보를 조합한 지도 데이터를 생성한다.
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        // 5. map 변수에 연결된 지도 객체에 데이터를 전달하여 화면에 표시한다.
        self.map.setRegion(coordinateRegion, animated: true)
        
        // 위치를 표시해줄 객체 생성, 핀 모양으로 해당 위치를 표시해줄 수 있다.
        let point = MKPointAnnotation()
        
        point.coordinate = location
        
        // 위치 표현 값을 추가한다.
        self.map.addAnnotation(point)
    }
    

}
