
<h3 align="center">CryptoApp</h3>

<div align="center">

  [![Status](https://img.shields.io/badge/status-active-success.svg)]() 
  ![GitHub top language](https://img.shields.io/github/languages/top/nowjordanhappy/SwiftUICryptoApp?color=yellow) 
  ![GitHub Repo stars](https://img.shields.io/github/stars/nowjordanhappy/SwiftUICryptoApp?style=social)
  [![GitHub Issues](https://img.shields.io/github/issues/nowjordanhappy/SwiftUICryptoApp.svg)](https://github.com/nowjordanhappy/SwiftUICryptoApp/issues)
  [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/nowjordanhappy/SwiftUICryptoApp.svg)](https://github.com/nowjordanhappy/SwiftUICryptoApp/pulls)
  [![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)
  
  <a href="https://www.buymeacoffee.com/nowjordanhappy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
</div>

# CryptoApp (SwiftUI)

This project is following the great and free course [SwiftUI Crypto App](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu) by [@SwiftfulThinking](https://github.com/SwiftfulThinking). I can not thank him enought for such a great course.

We are using Core Data, SwiftUI, Combine and others great tools. I added new features covering and using Clean Architecture, Mappers, Localization, SwiftLint and Unit Tests.


| Demo      | Full Demo |
| ----------|-----------|
| <img src="./screenshots/crypto-app-demo.gif" width="280" height="600" /> | <img src="./screenshots/crypto-app-full-demo.gif "width="280" height="600"/> |

## Table of Contents
- [CryptoApp (SwiftUI)](#crypto-app-swiftui)
  - [Table of Contents](#table-of-contents)
  - [Structure](#structure)
  - [API Reference CoinGecko](#api-reference-coin-gecko)
      - [Get Coins Data](#get-coins-data)
      - [Get Coin Detail](#get-coins-detail)
      - [Get Market Data](#get-market-data)
  - [New Features](#new-features)
  - [Tests](#tests)
  - [XCode](#xcode)
  - [Author](#author)
  - [License](#license)

 ## Structure<a name = "structure"></a>
The project has the following structure:

- **utilities**
- **extensions**
- **services**
- **data**
  - **remote**
  - **mappers**
- **models**
- **core**
  - **components**
  - **Launch**
    - **Views**
  - **Home**
    - **ViewModels** 
    - **View**
  - **Detail**
    - **ViewModels** 
    - **View**
  - **Settings**
    - **ViewModels** 
    - **Views**
- **Resources**
- **JsonResponse**

## API Reference CoinGecko<a name = "api-reference-coin-gecko"></a>
Using Free [CoinGecko API](https://docs.coingecko.com/reference/introduction) for this project. The free plan has a limitations: 
> The rate limit is ~30 calls per minutes and it varies depending on the traffic size. 

So sometimes to avoid this and be able to use the preview I stored the JSON response of the API calls so I can test the service calls like a fake response, and then only use the real API call when I build the app.

```
    URL BASE: https://api.coingecko.com/api/v3/
```

#### Get Coins Data<a name = "get-coins-data"></a>

```http
    GET coins/markets?vs_currency=usd&order-market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
```

#### Get Coin Detail<a name = "get-coins-detail"></a>

```http
    GET coins/{coinId}?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
```

#### Get Market Data<a name = "get-market-data"></a>

```http
    GET global
```


| Demo      | JSON Response File |
| ----------|-----------|
| Get Coins Data | marketsResponse.json |
| Get Coin Detail | bitcoinDetailResponse.json |
| Get Coin Detail | marketDataResponse.json |

If we exceed the rate limite, we can do like this in **CoinDetailDataService**:
Comment the line with dowlonad function:

```swift
// coinDetailsSubscription = networkingManager.download(url: url)
```

And uncomment the next like using the json file:
```swift
 coinDetailsSubscription = networkingManager.readLocalJSON(nameFile: "bitcoinDetailResponse"
```


## Tests<a name = "tests"></a>

- SparklineDtoMapperTest
- CoinDtoMapperTest
- CoinModelTest


## XCode<a name = "xcode"></a>

```
XCode Version 15.4 (15F31d)
macOS 14.5 (23F79)
```

## Author<a name = "author"></a>

- Jordan Rojas ([@nowjordanhappy](https://github.com/nowjordanhappy))

## License<a name = "license"></a>

MIT License

Copyright (c) 2024 Jordan R. A.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.