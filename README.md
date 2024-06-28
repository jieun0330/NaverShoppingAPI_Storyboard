# 🛍️ 네이버 쇼핑 검색

<picture>![네이버4](https://github.com/jieun0330/NaverShoppingAPI_Storyboard/assets/42729069/760ee4dc-8327-4037-b758-88d0bd0cf46a)</picture>

### 네이버 쇼핑 API를 통해 상품을 검색하고, 좋아요를 관리하는 앱
* `상품 검색` 네이버 쇼핑 API를 이용해 상품 검색
* `좋아요 추가/제거` 상품마다 좋아요 설정 및 취소 기능

<picture>![Group 517167397](https://github.com/jieun0330/NaverShoppingAPI_Storyboard/assets/42729069/d322b6a4-af9e-4abd-a482-101db3325774)</picture>

<br/>

## 🔨 개발기간
2024년 1월 18일 ~ 22일 (약 5일, 업데이트 진행중)

<br/>


## 🛠️ 사용기술 및 라이브러리
*  `UIKit(Storyboard)` `MVC` `SnapKit` `Alamofire` `Kingfisher` 

<br/>

## 🔧 구현 고려사항
- asyn/await를 활용한 효율적인 네트워크 호출
- 오프셋 기반 페이지네이션으로 추가 데이터 로드 구현
- Reusable Protocol을 사용해 스토리보드 식별자 명확화 및 인스턴스 생성 오류 감소
- Property Wrapper로 UserDefaults Service 로직 구조화
  

<br/>

## ⛏️ Trouble Shooting

**❌ 문제 상황**
<br/>
Cell 안에 있는 버튼 이벤트


**⭕️ 해결 방법:**
UIButton의 tag를 활용하여 액션 처리



```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    tableView.separatorStyle = .none
    
    if UserDefaultManager.shared.keywords.count == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoKeywordTableViewCell.identifier,
                                                 for: indexPath) as! NoKeywordTableViewCell
        
        cell.selectionStyle = .none
        tableView.isUserInteractionEnabled = false
        
        return cell
        
    } else {
        tableView.isUserInteractionEnabled = true
        
        keyword.text = "최근 검색"
        keyword.font = Fonts.font13
        deleteAll.setTitle("모두 지우기", for: .normal)
        deleteAll.titleLabel?.font = Fonts.font13
        deleteAll.setTitleColor(UIColor.pointColor, for: .normal)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier,
                                                 for: indexPath) as! KeywordResultsTableViewCell
        cell.keyword.text = UserDefaultManager.shared.keywords[indexPath.row]
        cell.selectionStyle = .none
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)),
                                    for: .touchUpInside)
        
        return cell
    }
}

@objc func deleteButtonClicked(_ sender: UIButton) {
    UserDefaultManager.shared.keywords.remove(at: sender.tag)
    keywordView.reloadData()
}

```

<br/>

## 🔧 추후 업데이트 사항

- [ ] 검색어 내역 중복 대응
- [ ] 최근 검색어 클릭 시 검색 시간순 리스트 업데이트
- [ ] 네트워크 통신 에러 처리
- [ ] 중복 API 통신 대응
- [ ] IdentifierProtocol 리팩토링

<br/>

## 👏🏻 회고
이번 프로젝트는 배운 것들을 적용하며 깊이 이해하려고 했다. 배운 부분을 넘어서 다양한 기술을 찾아보고 적용하려는 시도를 했다. 다양한 도전을 코드에 반영하려다 보니, 필수로 구현해야하는 사항들을 우선적으로 생각하지 못한 점이 아쉬웠다. 필수 구현 부분을 먼저 완성하고, 남은 시간에 추가적인 기능을 고민하고 적용해야 했었는데, 시간 분배에 있어서 미흡했다는 점이 뒤늦은 후회로 남는다. 실제 서비스라고 생각한다면, 닉네임 설정에서의 공백 처리, 키워드 공백 검색, 대소문자 검색, 중복 검색 등 다양한 예외처리가 필요함을 깨달았다. 또한, 같은 카테고리를 여러번 클릭했을 때 중복 통신을 하지 않도록 처리하는 등, 더욱 꼼꼼하게 사용자를 고려하는 개발자가 되어야겠다고 다짐하게 된 프로젝트였다.
이번 프로젝트를 통해 필수 구현 사항을 우선시하는 중요성과 예외 처리를 포함한 사용자 경험을 고려하는 것이 얼마나 중요한지 배웠다.
