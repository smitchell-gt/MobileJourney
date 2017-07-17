import Foundation

struct HarpURL {
    static let previewHarp = URL(string: "http://thorharp.com/photos/homeguaraboutcontact/home/homepage.jpg")
    
    static var thormahlen: Dictionary<String,URL> = {
        let thormahlenURLStrings = [
            "Serenade" : "http://thorharp.com/photos/Serenades/MiscSerandsummits/Ser6Rainbow41.jpg",
            "Ceili" : "http://thorharp.com/photos/Ceili/BlackCeili/Black%20KoaCeili.jpg",
            "Cygnet" : "http://thorharp.com/photos/Cygnets/Walnut%20Mahogany/NewWalnutCygnet.jpg",
            "Clare" : "http://thorharp.com/photos/Ceili/TheClare.jpg",
            "Swan" : "http://thorharp.com/photos/swans/Cherry/newoldswan.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key,value) in thormahlenURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
