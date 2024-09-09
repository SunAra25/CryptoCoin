//
//  ChartView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    let data: CoinDataResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    imageView()
                    Text(data.name)
                        .font(.largeTitle).bold()
                }
                
                Text("₩" + data.currentPrice.formatted())
                    .font(.largeTitle).bold()
                
                todayPriceView()
                
                priceView()
            }
            
            if let sparkPoint = data.sparklineIn7D?.price {
                let maxPoint = Int(sparkPoint.max() ?? 0) + 1
                let minPoint = Int(sparkPoint.min() ?? 0)
                
                let yRange = minPoint...maxPoint
                let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8),
//                                                                                Color.purple.opacity(0.4),
                                                                                Color.purple.opacity(0)]),
                                                    startPoint: .top,
                                                    endPoint: .bottom)
                Chart {
                    ForEach(Array(zip(sparkPoint.indices, sparkPoint)), id: \.0) { index, point in
                        LineMark(x: .value("Index", index),
                                 y: .value("Population", point))
                    }
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(.purple.opacity(0.8))
                    
                    ForEach(Array(zip(sparkPoint.indices, sparkPoint)), id: \.0) { index, point in
                        AreaMark(x: .value("Index", index),
                                 y: .value("Population", point))
                    }
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(linearGradient)
                }
                .chartXScale(domain: 0...sparkPoint.count)
                .chartYScale(domain: yRange)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .aspectRatio(1, contentMode: .fill)
                
            }
            
            Text(data.lastUpdate)
                .foregroundColor(.black.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "star")
                    .foregroundStyle(.purple)
            }
            .fontWeight(.black)
        }
        .padding()
    }
    
    func imageView() -> some View {
        AsyncImage(url: URL(string: data.image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
        } placeholder: {
            ProgressView()
        }
    }
    
    func todayPriceView() -> some View {
        Text((data.isPositivePriceChange ? "+" : "") + data.priceChangePercentage)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(data.isPositivePriceChange ? .red : .blue)
        + Text("  Today")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
    }
    
    func priceView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                PriceView(title: "고가", price: data.highPrice, color: .red)
                PriceView(title: "신고점", price: data.athPrice, color: .red)
                
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                PriceView(title: "저가", price: data.lowPrice, color: .blue)
                PriceView(title: "신저점", price: data.atlPrice, color: .blue)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct PriceView: View {
    let title: String
    let price: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(color)
                .padding(.vertical, 2)
            
            Text(price)
                .font(.title2)
                .foregroundColor(.black.opacity(0.8))
        }
    }
}

#Preview {
    NavigationView {
        ChartView(data: CoinDataResponse(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 74332727, high24H: 74775424, low24H: 71922540, priceChangePercentage24H: 1.84009, ath: 98576718, athDate: "2024-06-07T13:55:20.414Z", atl: 75594, atlDate: "2013-07-05T00:00:00.000Z", lastUpdated: "2024-09-09T12:05:36.909Z", sparklineIn7D: SparklineIn7D(price: [58361.898572657774,58389.63264298334,58189.0157041461,58611.971365503894,58574.54981135888,58352.56971842717,58468.85708149525,58493.30439764116,58564.85288879264,59245.901046591396,59081.894737399656,59231.01284443869,59116.72450306674,59387.948038510054,59522.41951320161,59320.34837813365,59101.41640164991,59029.26825418049,59014.71587794109,58958.44061193983,59093.98582741865,58856.27591419819,59032.872760216815,59037.52112338955,59220.85676099221,59228.65531821293,58102.7723974071,57820.0858422582,57817.938308376615,57748.66507488688,57784.356878454455,58167.34072631633,58181.32218165241,58208.6399239705,58045.417628622956,57786.55294435445,57813.69706883217,56160.11214505884,56618.69625548734,56780.01228562741,56619.156108408315,56670.89762145378,56403.90393632768,56578.869167875564,56689.10810974751,56734.14155966517,56472.8487542655,56522.61204502666,56627.70902517211,56551.269804683594,56471.709617939356,57576.97600585592,58120.08717111554,58393.35074858366,57822.842857142816,57761.163784722565,57983.83427211197,57995.679460486725,58183.50471420094,58140.1028915011,58087.76243010292,58011.60188693599,57749.22706431235,57676.00401788212,57249.670261443425,57155.08709783639,57063.580676781254,57164.44799899651,57163.90747340435,56990.33886814557,56709.122352946004,56762.03833637063,56671.36783827192,56758.79147824886,57125.4501514749,56404.29960422861,56047.62020016585,56443.49795536377,56522.572068468406,56414.454392688735,56040.03890248612,56200.64911676952,56037.78751865841,56116.08146432956,56276.037013870904,56004.497575819725,56538.22821522616,56746.166395129345,56707.739984513784,56511.21182542301,56447.17153444231,56366.669702838466,55812.44318192622,55782.373950107845,55937.23817176504,56048.55200528273,55883.98715130142,56805.55106357134,55324.91474531126,54481.51033537016,54008.69564063515,54302.84348921811,53760.5950543657,53752.943586110996,53491.82745304818,53304.61527374619,53803.47840034575,53700.61737164216,53955.11336282272,53900.28358818041,53794.89842133255,53813.390908389156,53806.07395267369,54028.17614823898,54171.76650009698,54276.07839995552,54260.814238357576,54358.71012996293,54312.33256235887,54410.95836986007,54433.38027259792,54560.49986085692,54601.959668171454,54641.181787137844,54814.8188490265,54512.29459997584,54149.5518521795,54238.749390463665,54358.127550689824,54038.41228294185,54014.23513028771,53988.87146955055,54121.47291189394,54260.86694365345,54333.79761749462,54365.447985786355,54445.118714845,54485.33028643299,54397.37848584855,54469.34594621885,54401.95281399067,54563.238380790855,54594.67297418731,54607.23537231982,54539.44726822426,54056.89287256887,54395.85929137016,54154.28103841953,53860.12093070046,53979.44957907279,54353.66485122087,54480.843627257076,54311.814163033945,54382.03265562702,54387.242734740685,54741.1679385244,54792.40755768575,55379.65405356332,54997.52935852939,55067.742344156555,55135.17544932909,54821.43946123485,54707.49549860948,54800.75740426883,54965.26535533279,55430.46154044937,55134.26782620553,55246.2305613595])))
    }
}
