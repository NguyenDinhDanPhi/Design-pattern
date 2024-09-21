import Foundation

enum Color
{
  case red
  case green
  case blue
}

enum Size
{
  case small
  case medium
  case large
  case yuge
}

class Product
{
  var name: String
  var color: Color
  var size: Size

  init(_ name: String, _ color: Color, _ size: Size)
  {
    self.name = name
    self.color = color
    self.size = size
  }
}


  
// Specification
protocol Specification
{
  associatedtype T
  func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ item: [T], spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    var color: Color
    init(_ color: Color) {
        self.color = color
    }
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class FilterProduct: Filter {
    typealias T = Product
    
    func filter<Spec: Specification>(_ item: [Product], spec: Spec) -> [T] where Product == Spec.T {
        var result = [Product]()
         for i in item {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        return result
    }
}
func main()
{
  let apple = Product("Apple", .green, .small)
  let tree = Product("Tree", .green, .large)
  let house = Product("House", .blue, .large)

  let products = [apple, tree, house]
let filter = FilterProduct()
    for i in filter.filter(products, spec: ColorSpecification(.green)) {
        print("filter \(i.name)")
    }
 
}

main()
