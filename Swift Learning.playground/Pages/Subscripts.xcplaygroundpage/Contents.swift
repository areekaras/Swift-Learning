

//read only subscript
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("Six time three is \(threeTimesTable[6])")


//Subscript with multiple parameters
struct Matrix {
    let rows, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    private func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Error: index out of bond")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Error: index out of bond")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
print("matrix before \(matrix.grid)")  //[0.0, 0.0, 0.0, 0.0]

matrix[0, 1] = 10
matrix[1, 0] = 12

print("matrix after \(matrix.grid)") //[0.0, 10.0, 12.0, 0.0]

//matrix[10, 10] = 23  //index error




//Type subscripts
enum Planet: Int {
    case earth = 1, mars, saturn, pluto, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

print(Planet[1])  //earth
print(Planet[3])  //saturn
