import Foundation

struct Exchange: Codable {
        let exchangeID: String
        let website: String
        let name: String
        let dataSymbolsCount: Int
        let volume1HrsUsd, volume1DayUsd, volume1MthUsd: Float

        enum CodingKeys: String, CodingKey {
            case exchangeID = "exchange_id"
            case website = "website"
            case name = "name"
            case dataSymbolsCount = "data_symbols_count"
            case volume1HrsUsd = "volume_1hrs_usd"
            case volume1DayUsd = "volume_1day_usd"
            case volume1MthUsd = "volume_1mth_usd"
        }
}

 
 
   
