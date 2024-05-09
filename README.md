# 🛍️ 네이버 쇼핑 검색

<picture>![네이버4](https://github.com/jieun0330/NaverShoppingAPI_Storyboard/assets/42729069/760ee4dc-8327-4037-b758-88d0bd0cf46a)</picture>

### 네이버 쇼핑 API를 통해 상품을 검색하고, 좋아요를 관리하는 앱'
* `상품 검색` 네이버 쇼핑 API를 이용해 상품 검색
* `좋아요 추가/제거` 상품마다 좋아요 설청 및 취소 기능


|<picture>![스크린샷-2024-04-26-오전-11 37 53](https://github.com/jieun0330/jieun0330/assets/42729069/cc1258b5-299e-42f4-82fc-810c918416d7)</picture>|<picture>![naver_1](https://github.com/jieun0330/jieun0330/assets/42729069/1fe502b3-b498-4780-973f-5b1ed0f7e686)</picture>|<picture>![naver_2](https://github.com/jieun0330/jieun0330/assets/42729069/53ae6441-44c2-4ac6-a65e-2522fa52cfaa)</picture>|<picture>![스크린샷-2024-04-26-오전-11 33 52](https://github.com/jieun0330/jieun0330/assets/42729069/e6582c87-faa2-402c-b294-180d927c24bb)</picture>
|---|---|---|---|


<br/>

## 🔨 개발기간
2024년 1월 18일 ~ 22일 (약 5일, 업데이트 진행중)


<br/>

## 🛠️ 사용기술 및 라이브러리
*  `UIKit(Storyboard)` `MVC` `SnapKit` `Alamofire` `Kingfisher` 

<br/>

## ⛏️ Trouble Shooting

### **Cell 안에 있는 버튼 이벤트**

**⭕️ 해결 방법:**
UIButton의 tag를 활용하여 액션 처리

<details>
<summary>Code</summary>

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
</details>
