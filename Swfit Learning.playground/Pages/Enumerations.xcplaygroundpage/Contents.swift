
/*
//CaseIterable - allCases

enum Beverages: CaseIterable {
    case tea, coffee, juice
}

let numberOfBeverages = Beverages.allCases.count
print(numberOfBeverages)

for beverageCase in Beverages.allCases {
    print(beverageCase)
}

 */


/*
//Associated values
enum BarCode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarCode = BarCode.upc(5, 43283, 98341, 4)

productBarCode = .qrCode("ABCDFRD")

switch productBarCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check) ")
case .qrCode(let productCode):
    print("QR Code: \(productCode)")
}

//if all associated values are either constants or variables then we can also write like this

productBarCode = .upc(2, 48957, 89433, 1)

switch productBarCode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check) ")
case let .qrCode(productCode):
    print("QR Code: \(productCode)")
}
 
*/


