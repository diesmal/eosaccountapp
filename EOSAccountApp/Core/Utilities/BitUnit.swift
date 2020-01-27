
protocol BitUnit {
    var kilobytes: Double { get }
    var megabytes: Double { get }
    var gigabytes: Double { get }
    
    var formattedBitUnit: String { get }
}

extension BitUnit where Self: SignedInteger {
    var kilobytes: Double {
        return  Double(self) / 1024.0
    }
    
    var megabytes: Double {
        return kilobytes / 1024.0
    }
    
    var gigabytes: Double {
        return megabytes / 1024.0
    }
    
    var formattedBitUnit: String {
        switch abs(self) {
        case 0..<1024:
            return "\(self) bytes"
        case 1024..<(1024 * 1024):
            return "\(String(format: "%.2f", self.kilobytes)) kb"
        case 1024..<(1024 * 1024 * 1024):
            return "\(String(format: "%.2f", self.megabytes)) mb"
        default:
            return "\(String(format: "%.2f", self.gigabytes)) gb"
        }
    }
}

extension Int64: BitUnit {}
extension Int: BitUnit {}
