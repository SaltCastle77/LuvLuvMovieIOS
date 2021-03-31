# LUVLUVMOVIE  IOS 개발버전

> vue.js와 Django로 만들었던 LUVLUVMOVIE의 IOS앱버전

## 1일차

### 테이블 뷰를 이용한 데이터 목록 구현

> 영화의 썸네일 그리고 제목, 일자를 포함한 목록을 보여주기 위해서 TableView를 이용하여 목록을 구현한다.

![image-20210331230951882](README.assets/image-20210331230951882.png)

하나의 화면을 의미하는 씬은 보통 하나의 View Contriller로 구성되는데 위에서응 `List View Controller`가 씬을 담당한다. `Table View` 가 최상위 루트뷰, 여러개의 행을 여기서는 `ListCell` 이라고 하고 다시 내부 `content View`를 갖는다. 



1) 테이블 뷰를 구현하기 위해서는 `UIViewContoller` 대신에 `UITableViewController` 클래스를 상속받아야한다.

- 화면이 구성되는 요소마다 대응하는 클래스가 있지만 다 외울수 없고 Reference를 찾아가면서 해야한다. 자주 쓰는건 외우는게 좋아!

2) `ListCell`은 타입이 나눠져 있으며 프로토타입 셀 = `ListCell` 을 참조하기 위해서 식별 아이디를 부여하는게 좋다. 코드에서 프로토 타입 셀을 참조할 때 사용됨

3) `TableView`의 데이터 소스는 정적방법과 계속 데이터가 바뀌는 동적 방법이 있는데 대부분 동적이다. 



#### 1. 데이터 모델링

- MoiveVO.swift

  > 값이 없을 수 있으므로 옵셔널 변수로 저장한다.

```swift
//
//  MovieVO.swift
//  LuvLuvMovieIOS
//
//  Created by 염성훈 on 2021/03/30.
//

import Foundation

class MovieVO {
    var thumbnail: String? //썸네일 이미지 주소
    var title : String? // 영화 제목
    var description: String?
    var detail : String?
    var opendate : String?
    var rating : Double?
}
```

- ListViewcontrolller.swift

```swift
import UIKit

class ListViewController: UITableViewController{
    // 튜플 아이템으로 구성된 데이터 세트
    
    var dataset = [
        ("다크 나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95),
        ("호우시절", "떄를 알고 내리는 좋은 비", "2009-10-08", 7.31),
        ("말할 수 없는 비밀", "여기서 너 까지 다섯 걸음", "2014-05-07",9.19)
    ]
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()

        for (title, desc, opendate, rating) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func viewDidLoad() {
        
    }
}
```

- 배열문법 

> 아래 문법 이이해가 안갓는데 [] 안에있는 MovieVO의 데이터를 요소로 갖는 빈 배열을 생성한다는 것이다. 지금 MovieVO는 클래스이기 때문에 저기 배열에는 MovieVO 클래스 즉 타입이 datalist 변수에 지정된다.

```swift
var datalist = [MoiveVO]()
```

- lazy문법

1) lazy는 변수를 정의하면 참조되는 시점에 맞춰 초기화 되서 메모리 낭비를 줄이ㅣㄹ 수 잇다. 

2) lazy를 붙이지 않은 프로퍼티는 다른 프로퍼티를 참조 할 수 없기 때문에 꼭 써야한다. list 배열 변수를 초기화 하는데에는 dataset 프로퍼티가 필요하기 떄문



#### 2. 데이터 뷰와 소스 연동

> 생각할점 : 데이터 소스를 연동할떄 즉 뭘 보여줄껀데? 1) 몇개의 행으로 구성되나 2) 각 행의 내용은 어떻게 구성되나? 를 생각한다. 

```swift
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 생성해야 할 행의 개수를 반환하는 메소드 상위 클래스인 UITableView에 지정되어있어 override해줘야한다.
        return self.list.count // 생성되는 list갯수만큼 리턴 해줘야한다.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 테이블 뷰 의 개별 행 내용을 담는 것
        let row = self.list[indexPath.row] // 행의 번호를 알고 싶을떄 list[indexPath.row]를 사용하면 알 수 있다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")! // cell 객체를 생성,
        cell.textLabel?.text = row.title // 만약 테이블 셀의 textLabel 속성에 값이 있으면 하위 속성인 .text에 row.title 값을 대입하고 , 없으면 아무것도 처리하지 않는다. 라는 의미 오류가 발생안해! 옵셔널 체인
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //테이블 셀을 클릭했을때 실행되는 함수
        NSLog("선택된 행은\(indexPath.row) 번째 행입니다.")
    }
```

- 네비게이션 콘트롤러를 삽입해서 아이템을 추가하고, 타이틀을 입력시킨다.

> [Editor] -> [Embed In] -> [Navigator Controller] 를 통해 해당 컨트롤러에 네비게이션 바를 삽입할 수 있다. 

- 내용이 없으면 빈목록이 줄처럼 표시되는게 불편해! -> 오브젝트 라이브러리에서 [View] 객체를 드래그해서 프로토타입 셀 아래 영역에 추가한다.





