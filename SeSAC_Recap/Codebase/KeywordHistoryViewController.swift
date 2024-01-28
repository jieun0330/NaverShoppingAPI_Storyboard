//
//  KeywordHistoryViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/26/24.
//

import UIKit
import SnapKit

class KeywordHistoryViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let recentSearch = UILabel()
    let deleteAll = UIButton()
    let tableView = UITableView()
    
    // 클래스에서 가장 중요한 점은 상속
    // 상속받은 클래스는 하위클래스라고 한다
    // 상속을 해주는 클래스는 슈퍼클래스라고 한다
    
    // override는 상속되는 슈퍼클래스의 메서드나 프로퍼티를
    // 내가 마음대로 바꿀 수 있게 해주는 키워드이다 ?
    // 슈퍼클래스로부터 상속받은 메서드, 프로퍼티를 재정의하는 키워드
    
    // 슈퍼클래스에서 뭘 상속해줬는데 ?? ? ? ? ? ? 🚨
    // 아? 뭐 backgroundColor, navigationItem 이런걸 상속해주면
    // 내가 black, 고래밥 처럼 바꿔서 사용한다는건가? ?? ? 맞는듯
    
    // 그러면 viewWillAppear도 override해서 썼잖아?
    // 그러면 이 ViewController안에는 슈퍼클래스가 두개있는건가? 🚨
    // -> 노옵 노옵오노오봉노~~~~!!~!!~
    // 슈퍼클래스는 저 뷰컨이고 그냥 그 안에서 재정의할 수 있는 것들을 만드는것이여 지은아
    
    // 슈퍼클래스라는게 뭔데
    // 슈퍼클래스가 viewDidLoad가 아니라 엥 ?
    // 아 viewDidLoad를 원하는대로 재정의해서 써라~ 요거구나?
    
    // 결론
    // 슈퍼클래스는 KeywordHistoryViewController인거고
    // 이 슈퍼클래스가 메서드랑 프로퍼티를 뭐 주긴 하는데
    // 그걸 내 입맛대로 바꿔서 쓰겠다~ 하는게 override 재정의 하는것들이다~
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationItem.title = "떠나고싶은 고래밥님의 새싹쇼핑"
        
        // 부르는 순서도 꼬이지 않아야함
        // addSubView -> 디자인 요소 -> Constraints 주기
        configureHierachy()
        configureView()
        configureConstraints()
        
        // AutoresizingMask가 autoLayoutConstraints로 변환되는지 여부를 물어보는 코드
        // 원래는 스토리보드에서 잡을 때는 Autoresizing이 자동으로 꺼지는데,
        // 내부적으로 코드를 작성할때는 false 구문을 작성해야 한다
        // 벗뜨
        // 스냅킷 내부에서 이 작업을 해주기 때문에 코드 작성할 필요가 없다
        // 스냅킷 체고~
        //        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureHierachy() {
        
        // 써먹기~2
        [searchBar, recentSearch, deleteAll, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    func configureView() {
        
        // searchbar는 UI적으로 바꿀게 없으니까 delegate만 불러오는구나???
        searchBar.delegate = self
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        recentSearch.text = "최근 검색"
        recentSearch.textColor = Colors.textColor
        
        deleteAll.setTitle("모두 지우기", for: .normal)
        deleteAll.setTitleColor(Colors.pointColor, for: .normal)
        deleteAll.addTarget(self, action: #selector(deleteAllClicked), for: .touchUpInside)
        
        // dataSource: 데이터를 받아 뷰를 그려주는 역할
        // -> cellForRowAt: 여기 안에 cell view 그려주는 코드를 작성하잖아???
        // 다른걸로는 numberOfRowsInSection 섹션 안에 행이 몇개 있냐~
        // dataSource는 보여주는 것을 담당했다면
        
        // delegate는 그 보이는 부분 중 어떤 것을 클릭하거나 행동을 했을 때,
        // 그 행동에 대한 동작을 수행하게 된다
        // didSelectRowAtIndexPath 눌렀을때~ 동작하는거~!
        
        // 그래서 아래 코드를 작성했을 때 자동 생성되는 두 프로토콜
        // UITableViewDataSource, UITableViewDelegate
        // 그래서 이 두 프로토콜을 채택하면 테이블뷰가 그 역할을 할 수 있도록 함~!
        
        // 아 그래서 delegate랑 datasource의 위임을 바로 이 KeywordHistoryViewController가 하겠다~ 해서
        // KeywordHistoryViewController가 self인거구나 ㅇㅋㅇㅋㅇㅋㅇㅋㅇㅋ
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀을 등록할 때는 nibName과 forCellReuseIdentifier를 넣어주고
        // 아래 cellForRowAt에서 셀 재사용 시에도 withIdentifier를 넣어줘야한다
        // 3개의 파라미터가 모두 String값을 받게 되어있다
        // 벗뜨
        // String이기 때무네 프로토콜로 만들어준다 -> Protocol.swift
        
        // register: 셀을 등록하는데 사용하는 메서드
        // resueIdentifier: 셀의 ID
        tableView.register(KeywordHistoryTableViewCell.self, forCellReuseIdentifier: KeywordHistoryTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.rowHeight = 60
    }
    
    func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        deleteAll.snp.makeConstraints { make in
            make.top.equalTo(recentSearch)
            make.trailing.equalTo(view.safeAreaInsets).offset(-10)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(recentSearch.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func deleteAllClicked() {
        UserDefaultManager.shared.keywords.removeAll()
        tableView.reloadData()
    }
}

// 프로토콜 안에 들어가서 보면 쓸 수 있는 메소드들이 몽땅 있다요
extension KeywordHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultManager.shared.keywords.count
    }
    
    // 타입 캐스팅
    // 업캐스팅, 다운캐스팅이란 개념이 있는데
    // as? 타입 변환
    // as? -> 옵셔널이여서 as! -> 강제 다운캐스팅
    // 셀 등록을 하는데도 불구하고 캐스팅까지 해서 그 안에 있는 친구들을 쓸 수 있게 해야되는구나???? 🚨 맞나?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordHistoryTableViewCell.identifier, for: indexPath) as! KeywordHistoryTableViewCell

        cell.productName.text = UserDefaultManager.shared.keywords[indexPath.row]
        // xmarkButton 클릭 시 -> 셀 하나씩 없애는 작업
        // 모아나가 tag를 쓰는 방법을 알려줬으니 다른 방법을 찾아보자
        // 1. 버튼에 태그 부여하는 방법
        // 2. delegate 패턴 사용 처리 -> 두번 정도 코드 작성하다가 포기
        // 3. callBack함수 클로저 사용 -> 화면이 많아지면 delegate 패턴 네이밍이 힘들고 추적하기도 힘들다고 하니까 이걸로 다시 도전
        
        // 3.1 Cell에 클로저 프로퍼티를 추가한다
        // 3.4 기능 구현해준다
        // unowned는 싸이클을 막기 위함이다
        // 지금 구조는 ViewController -> TableView -> TableViewCell -> xmarkButtonAction 순서인데
        // 여기서 그냥 self로 구현하게 되면 xmarkButtonAction이 ViewController를 보유하게 되어 무한싸이클이 돈다
        // 그래서 weak나 unowned를 써줘야 한다
        
        // 몬소린지 모르겠는데 구현은 되네 망할래미🚨🚨🚨🚨🚨
        cell.xmarkButtonAction = {[unowned self] in
            UserDefaultManager.shared.keywords.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return cell
    }
}

// extension으로 빼는거랑 그냥 위에 함수 만드는거랑 무슨 차이지?
// 그냥 보기 좋으라고 빼는건가
// ->
// 1. 각각의 기능 별로 코드를 나눠서 정리하거나
// 한곳에 여러 프로토콜을 나열하지 않도록 정렬해주는 역할을 한다
// 2. 외부 라이브러리나 프레임워크를 가져와서 사용할 경우에는
// 원본 소스를 수정할 수 없어 원하는 기능을 추가하기 어렵다, 이때 extension을 활용해서 추가할 수 있다
// ???? 외부 라이브러리??? -> 우리가 썼던 snapkit? textfield? 이런건가? 🚨🚨🚨🚨🚨

// extension은 새로운 기능을 추가할 수는 있지만, 기존 새로운 기능을 재정의할수는 없다
// 재정의 -> override
extension KeywordHistoryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UserDefaultManager.shared.keywords.insert(searchBar.text!, at: 0)
        searchBar.text?.removeAll()
        tableView.reloadData()
        
    }
}

//#Preview {
//    KeywordHistoryViewController()
//}
