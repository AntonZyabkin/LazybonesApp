![enter image description here](https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/logo.png)
# Содержание:
 1. Аннотация 
 2. Установка и требования 
 3. Стек технологий и технические требования 
 4. Функциональные возможности 
 5. Скриншоты
 6. Mockups

## Аннотация

Приложение на заказ для руководителя малого бизнеса. Позволяет контролировать основные финансовые показатели торговой точки, просматривать список входящий электронных документов, просматривать календарь с фактическим графиком работы сотрудников, рассчитывать текущую задолженность перед контрагентами, подготавливать и создавать платежи на подпись в банке Точка.

## Установка
Скопируйте проект на ваше устройство. Загрузите и установите все модули, определенные в Podfile (pod install)

> *Внимание! Для работы со всеми функциями приложения необходимы личные кабинеты в системах: sbis.ru, ofd.ru, tochka.com*

## Используемый стек технологий и решений:

 - **iOS 13+** 
 - **Swift 5** 
 - NetworkService: **Moya(MultiTarget) + URLSession**
 - DecoderService: **JSONDecoder, Codable** 
 - KeychainService: **SwiftKeychainWrapper** 
 - Архитектура:  **MVP + ModuleBuilder** 
 - Графики: **Charts** 
 - Календарь: **custom UICollectionView** 
 - Многопоточность:  **GCD**
 - Верстка: **AutoLayout** 
 - UI:  **UIKit**

## Функциональные возможности:

### Используемые API

 - [Точка  Банк](https://enter.tochka.com/doc/v2/redoc#section/Pro-API)
  -  [Сбис](https://sbis.ru/help/integration/api)
  -  [OFD](https://ofd.ru/razrabotchikam/cheki-i-kkt)

### Для работы с приложением необходимо авторизоваться в трех сервисах:
- Точка  Банк (JWT  bearer  auth) 
- Сбис (логин + пароль) 
- OFD (логин +  пароль)

### Модули
#### ФинТабло:

 - запрашивает выписку с суточными отчетами по сменам визуализириет
 - динамику выручки за последние 3 недели в виде гистограммы отображает
 - ключевые показатели за текущую смену

#### Входящие электронные документы:
- запрашивает 100 последних  входящих пакетов документов
- отображает список входящих электронных документов (счет фактуры, товарные накладные, счета, акты сверок и тп)

#### Календарь:
- кастомный UICollectionView в виде месячного календаря с привязкой даты к дню недели
- форматирование ячейки дня на основе ФИО сотрудника
- отображает выручку, количество чеков за смену

#### Банковский модуль:
- запрашивает и визуализирует текущий баланс расчетного счета в банке Точка
- показывает дату последнего формирования платежей
- формирует список текущих задолженностей перед контрагентами по данным поступления товарных накладных
- формирует платежные поручения по сохраненным данным контрагентов, если данных нет, то рекурсивно запрашивает выписки с расчетного счета в поисках реквизитов р/с контрагента
- отправляет платежные поручения в банк Точка «на подписание»

## Скриншоты
<img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC1.png" width="252" height="503" />  <img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC2.png" width="252" height="503" />  <img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC3.png" width="252" height="503" />  <img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC4.png" width="252" height="503" />  <img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC5.png" width="252" height="503" />  <img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/SC6.png" width="252" height="503" />  

## Mockups
<img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/mockup1.jpg" width="400" height="532" /> 
<img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/mockup2.jpg" width="500" height="333" /> 
<img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/mockup3.jpg" width="333" height="500" /> 
<img src="https://raw.githubusercontent.com/AntonZyabkin/LazybonesApp/main/Screenshots/mockup4.png" width="730" height="547" /> 
