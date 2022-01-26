//
//  MeController.swift
//  TechApp
//
//  Created by 이한규 on 2021/09/27.
//


import Foundation
import Firebase


import UIKit
import Foundation
extension UIImageView {
    func setImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {

            /// cache할 객체의 key값을 string으로 생성
            let cachedKey = NSString(string: url)

            /// cache된 이미지가 존재하면 그 이미지를 사용 (API 호출안하는 형태)
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                self.image = cachedImage
                return
            }

            
            //얘는 메모리에 없으면 바로 url 에서 다운받으러감
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, result, error) in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {

                        /// 캐싱
                        ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}




class ImageCacheManager {
    static let shared = NSCache<NSString,UIImage>()
    private init() {}
}
func imageDownFromUrl(url : String){//url이 스트링 , 메모리에 없으면 가지러간다.
    var image = UIImage()
   // DispatchQueue.global(qos: .background).async {
        let cachedKey = NSString(string: url)
        //싱글톤먼저확인
        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey.lastPathComponent as NSString){
            //메모리에있을때
            image = cachedImage
            return
        }
        
        //메모리에 없을때
        guard let url = URL(string: url) else { return}
        URLSession.shared.dataTask(with: url) { (data,result,error) in
            guard error == nil else {
                //DispatchQueue.main.async { [weak self] in
                    image = UIImage()//error있으면 비운다./
                    return
            }
            //DispatchQueue.main.async {//사실 뷰에 올려놓는것이 아니기 때문에 안해도된다.
                if let data = data, let image2 = UIImage(data: data){
                    image = image2
                    ImageCacheManager.shared.setObject(image, forKey: cachedKey.lastPathComponent as NSString)//싱글톤저장.
                }
            //}

        }.resume()
        //}
    }


class MeViewController: UIViewController {//디스크에서 가져오기.
    func fetchImageFromDiskCache(url : URL)-> UIImage{
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return UIImage()}
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.lastPathComponent)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath.path) {
            guard let imageData = try? Data(contentsOf: filePath) else { return UIImage() }
            guard let image = UIImage(data: imageData) else { return UIImage()}
            
            ImageCacheManager.shared.setObject(image, forKey: url.lastPathComponent as NSString)//싱글톤저장
            print("저장?\(url.lastPathComponent as NSString)")
            print("dd",image.description)
            return image
            //self.imageVIew.image = image// 잘가져온다.
        }
        return UIImage()
       

    }
    // MARK - Properties
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet var name: UILabel?
    @IBOutlet var field: UILabel?
    @IBOutlet var company: UILabel?
    @IBOutlet var contents: UITextView!
    private var locationAndInjuredVM : LocationAndInjuredViewModel?
    private var myInformationVM: MyInfoViewModel?
   
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        practice()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK - API
    
    func practice(){
        imageDownFromUrl(url: "https://ibb.co/tYmfFYt")
        fetchImageFromDiskCache(url: URL(string: "https://ibb.co/tYmfFYt")!)
        let imageCache = NSCache<NSString, UIImage>()
        var image = UIImage(systemName: "person")!
        var url = URL(string: "https://ibb.co/tYmfFYt")!
        imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
        if let imageca = imageCache.object(forKey: url.lastPathComponent as NSString) {//메모리에서 이미지 가져오기.
            print("이미지캐시 메모리에 존재한다.")
            //self.imageVIew.image = imageca
        }//메모리에서 이미지가 있을때.
        
        ImageCacheManager.shared.setObject(image, forKey: url.lastPathComponent as NSString)//싱글톤에저장
        
        
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        print("cache: \(path)")
        
//        guard let path2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}//위와 약간 표기가 다르다.
//        print(path2)
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.lastPathComponent)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath.path) {//disk에 있는지 확인.
            //디스크에 없다.
            
            fileManager.createFile(atPath: filePath.path, contents:image.jpegData(compressionQuality: 0.4), attributes: nil)
            
            imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
            //메모리캐시에 저장해놓는다.
        }//없으면
        
        else {//디스크에 있어.
            //디스크에 있는데 메모리에는 없으면 메모리에 저장하기
            self.imageVIew.image = fetchImageFromDiskCache(url: URL(string: "https://ibb.co/tYmfFYt")!)
            imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
            print("이미잇다@@")
            
            
        }//있으면

        //디스크 캐시에도 없으면 url다운.
        
        
        print("dd")

    }
    func fetchUser() {
        showLoader(true)
        FirebaseWebservice.fetchMyInfo { myInfo in
            self.myInformationVM = MyInfoViewModel(myInfo)
            self.showLoader(false)
            self.name?.text = self.myInformationVM?.name
            self.company?.text = self.myInformationVM?.company
            self.contents?.text = self.myInformationVM?.contents
            self.field?.text = self.myInformationVM?.field
        }
    }

    // MARK  - Helper
    
    @IBAction func goToAccident(_ sender: UIButton) {
        let controller = AccidentsTableController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func fetchAccident(_ sender: UIButton) {
        showLoader(true)
        self.fetchAccidentFromFirebase{
            self.showLoader(false)
        }
        //showLoader(false)
    }

    private func fetchAccidentFromFirebase(completion : @escaping () -> Void){
        FirebaseWebservice.fetchAccident {  accident in
                self.locationAndInjuredVM = LocationAndInjuredViewModel(accident: accident)
            self.contents.text = self.contents.text +  "\n\(self.locationAndInjuredVM!.location)에서\n\(self.locationAndInjuredVM!.injured)명 사고 발생했습니다."
            completion()
            //self.showLoader(false)
            
        }
    }
}

extension MeViewController : AccidentControllerDelegate {
    func controller( vm: AccidentViewModel) {
        guard let resultInjured = vm.resultInjured , let resultLocation = vm.resultLocation else {return}
        let data = ["location":resultLocation,"injured":resultInjured] as [String:Any]
        //hash형태로
       COLLECTION_ACCIDENT.document("data").setData(data) { error in
            if let error = error { print(error.localizedDescription)
                return
            }
        }
    }
}







