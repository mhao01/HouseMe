import UIKit

struct DemoConstants {
    static let button = DemoConstantsButton()
    
    static let initialImage = (
        fileName: "Images/bathroom.jpg",
        description: "The Great Auk drawing by John James Audubon, 1827-1838."
    )
    static let houseDescription = (
        description: "Price: $4200 \n \nOccupancy: 4-6"
    )
    
    static let houses = [
        (location: CLLocationCoordinate2D(latitude: 37.87, longitude: -122.27),description:  "Price: $4200 \n \nOccupancy: 4-6"
            
        ),
        (location: CLLocationCoordinate2D(latitude: 37.867, longitude: -122.28),description:  "Price: $2000 \n \nOccupancy: 3-5"
            
        ),
        (location: CLLocationCoordinate2D(latitude: 37.87, longitude: -122.26),description:  "Price: $4200 \n \nOccupancy: 2-4"
            
        ),
        (location: CLLocationCoordinate2D(latitude: 37.865, longitude: -122.265),description:  "Price: $2000 \n \nOccupancy: 3-5"
            
        )
        
        
    ]
    static let localImages = [
        (
            fileName: "Images/1.jpg"),
        (
            fileName: "Images/2.jpg"
        ),
        (
            fileName: "Images/3.jpg"),
        (
            fileName: "Images/4.jpg"
        ),
        (
            fileName: "Images/5.jpg"),
        (
            fileName: "Images/6.jpg"
        ),
        (
            fileName: "Images/7.jpg"),
        (
            fileName: "Images/8.jpg"
        )
    ]
    
    static let remoteImageBaseUrl = "http://evgenii.com/files/2015/06/auk_demo/"
    
    static let remoteImages = [
        (
            fileName: "Alca_Impennis_by_John_Gould.jpg",
            description: "Alca impennis by John Gould: The Birds of Europe, vol. 5 pl. 55, 19th century."
        ),
        (
            fileName: "Great_Auk_Egg_Bent.jpg",
            description: "Great Auk egg, U. S. National Museum, in a book by Arthur Cleveland Bent, 1919."
        ),
        (
            fileName: "Great_auk_with_juvenile.jpg",
            description: "Great auk with juvenile drawing by John Gerrard Keulemans, circa 1900."
        ),
        (
            fileName: "Keulemans-GreatAuk.jpg",
            description: "Great Auks in summer and winter plumage by John Gerrard Keulemans, before 1912."
        ),
        (
            fileName: "SimlulateNoImage.jpg",
            description: "Image download failure test."
        )
    ]
}

struct DemoConstantsButton {
    let borderWidth: CGFloat = 2
    let cornerRadius: CGFloat = 20
    let borderColor = UIColor.white
}
