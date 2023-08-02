//
//  BlogLikeView.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import UIKit
protocol BlogLikeViewSpec{
    func UpdateCollectionView(cellList : [KakaoLikeModel])
    func RouteReviewController(routeCellInfo : ReviewModel)
}
extension BlogLikeViewController : BlogLikeViewSpec{
    func UpdateCollectionView(cellList : [KakaoLikeModel]){
        BlogLikeList = cellList
        BlogTableView.reloadData()
        
    }
    func RouteReviewController(routeCellInfo : ReviewModel){
        print(Logger.Write(LogLevel.Info)("BlogLikeViewController")(18)("웹뷰로 전환하는 기능 필요할듯.."))
    }
}


extension BlogLikeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BlogLikeList.count // 하드코딩
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == BlogTableView {
            print(Logger.Write(LogLevel.Info)("BlogLikeViewController")(30)("더미 데이터를 API데이터 변환 필요"))
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell") as? MTableCell {
                var data = BlogLikeList[indexPath.item]
                cell.contentLabel.text = data.blogname
                cell.saveTime.text = data.saveTime
                cell.photoImageView.image = UIImage(named: "search")?.resized(toWidth: 50, toHeight: 150)//기본 이미지로 설정..나중에 이미지 찾자.
                if let imageUrl = URL(string: data.ThumbNail) {
                    let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                        if let error = error {
                            print(Logger.Write(LogLevel.Error)("HomeViewController")(128)("error -> \(error.localizedDescription)"))
                            return
                        }
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.photoImageView.image = image

                            }
                        }
                    }
                    task.resume()
                }
               // cell.photoImageView.image = UIImage(named: "search")?.resized(toWidth: 50, toHeight: 150)
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! MTableCell
        BlogLikePresenterSpec.OnSelectedItem(cellinfo: ReviewModel(BlogName: "하드코딩", Cotent: cell.contentLabel.text!, ImageURl: "search", IsLike: false))
    }
}

class BlogLikeViewController: BaseViewController {
    var BlogLikePresenterSpec : BlogLikePresenterSpec!
    var BlogheaderTextLabel = MTextLabel(text : "블로그 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
    var BlogTableView = MTableView()
    var BlogLikeList : [KakaoLikeModel] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(BlogheaderTextLabel)
        view.addSubview(BlogTableView)
        
        BlogTableView.dataSource = self
        BlogTableView.delegate = self
        BlogTableView.register(MTableCell.self, forCellReuseIdentifier: "BlogTableViewCell")
        self.navigationController?.navigationBar.isHidden = true
        
        SetupLayout()
        NavigationLayout()
        BlogLikePresenterSpec.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        BlogLikePresenterSpec.loadData()
    }
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "추천 영상"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
    }
    func SetupLayout(){
        //블로그 좋아요 라벨
        BlogheaderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BlogheaderTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            BlogheaderTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            BlogheaderTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            BlogheaderTextLabel.heightAnchor.constraint(equalToConstant: 20) //
        ])
        //블로그 좋아요 테이블 뷰
        BlogTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BlogTableView.topAnchor.constraint(equalTo: BlogheaderTextLabel.safeAreaLayoutGuide.bottomAnchor,constant: 20),
            BlogTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            BlogTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            BlogTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),
            
        ])
    }
    
}
