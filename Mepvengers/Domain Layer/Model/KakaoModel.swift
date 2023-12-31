


struct KakaoAPI: Codable {
    var documents: [Document]
    let meta: Meta
    init(){
        self.documents = []
        self.meta = Meta(isEnd: false, pageableCount: 0, totalCount: 0)
    }
    
    init(documents: [Document], meta: Meta) {
        self.documents = documents
        self.meta = meta
    }
}

struct Document: Codable, Hashable {
    var blogname: String
    var contents: String
    var datetime: String
    var thumbnail: String
    var title: String
    var url: String
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(title)
    }
    static func == (lhs: Document, rhs: Document) -> Bool {
       
        return lhs.title == rhs.title && lhs.datetime == rhs.datetime
    }
    init(blogname: String, contents: String, datetime: String, thumbnail: String, title: String, url: String) {
        self.blogname = blogname
        self.contents = contents
        self.datetime = datetime
        self.thumbnail = thumbnail
        self.title = title
        self.url = url
    }
    init() {
        self.blogname = ""
        self.contents = ""
        self.datetime = ""
        self.thumbnail = ""
        self.title = ""
        self.url = ""
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
    
    init(isEnd: Bool, pageableCount: Int, totalCount: Int) {
        self.isEnd = isEnd
        self.pageableCount = pageableCount
        self.totalCount = totalCount
    }
    init() {
        self.isEnd = false
        self.pageableCount = 0
        self.totalCount = 0
    }
}
