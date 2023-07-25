//
//  BlogLikeView.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import UIKit

extension BlogLikeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyImageName1.count // 하드코딩
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == BlogTableView {
            print(Logger.Write(LogLevel.Info)("BlogLikeViewController")(18)("더미 데이터를 API데이터 변환 필요"))
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell") as? MTableCell {
                cell.contentLabel.text = "Test"
                cell.saveTime.text = "ABC"
                cell.photoImageView.image = UIImage(named: dummyImageName1[indexPath.item])?.resized(toWidth: 50, toHeight: 100)
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
}

class BlogLikeViewController: BaseViewController {
    var BlogheaderTextLabel = MTextLabel(text : "블로그 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
    var BlogTableView = MTableView()
    var BlogTableViewCell = MTableCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(BlogheaderTextLabel)
        view.addSubview(BlogTableView)
        
        BlogTableView.dataSource = self
        BlogTableView.register(MTableCell.self, forCellReuseIdentifier: "BlogTableViewCell")
        self.navigationController?.navigationBar.isHidden = true
        
        SetupLayout()
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
