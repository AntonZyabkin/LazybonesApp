//
//  PaymentViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation

protocol PaymentViewPresenterProtocol {
    func viewDidLoad()
    func payOffDebtButtonDidPressed()
}

protocol PaymentViewPresenterDataSource: AnyObject {
    func updateModel(_ documents: SbisShortComingListResponse)
}

final class PaymentViewPresenter {
    
    private var debtDict: [String: Contractor]!
    var paymentRequestArray: [TochkaPaymentForSignRequest] = []
    private var initResponse: TochkaInitStatementResponse? = TochkaInitStatementResponse(data: nil, code: nil, id: nil, message: nil, errors: nil)
    private var statement: TochkaGetStatementResponse? = TochkaGetStatementResponse(data: nil, code: nil, id: nil, message: nil, errors: nil)

    
    private let moduleBuilder: Builder
    private let tochkaAPIService: TochkaAPIServicable
    private let keychainService: KeychainServicable
    var view: PaymentViewProtocol?
    
    init(tochkaAPIService: TochkaAPIServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.tochkaAPIService = tochkaAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
    
    //MARK: - Производит проверку наличия токена в Keychain
    private func checkJWT() {
        if let token = keychainService.fetch(for: .tochkaJWT) {
            fetchBalance(token)
        } else {
            print("where is no JWT")
            self.showJWTViewController()
        }
    }
    
    //MARK: - запрашивает баланс по счету и отображает на Вью
    private func fetchBalance(_ JWT: String) {
        let getJWTrequest = TochkaBalanceRequest(JWT: JWT)
        tochkaAPIService.getBalanceInfo(getJWTrequest) { [weak self] result in
            switch result {
            case .success(let responce):
                if let currentAmount = responce.data?.balance.first?.amount.amount, let accountId = responce.data?.balance.first?.accountID {
                    let _ = self?.keychainService.save(accountId, for: .tochkaAccountID)
                    self?.setBalanceLabel(currentAmount)
                    self?.fillPaymentRequestArray(jwt: JWT, accountId: accountId)
                } else if responce.errors != nil || responce.message != nil {
                    self?.showJWTViewController()
                    print(responce.errors?.first?.message ?? "unexpected error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: ВСПОМОГАТЕЛЬНАЯ ф-я для формата лейбла
    private func setBalanceLabel(_ balance: Double) {
        self.view?.currentBalanceLabel.text = String(balance) + " \u{20BD}"
    }
    
    //MARK: - пуш ф-я для получения токена авторизации
    private func showJWTViewController() {
        self.view?.navigationController?.pushViewController(moduleBuilder.buildTochkaJWTViewController(), animated: true)
    }
    
    //MARK: - Создадим словарь с задолжностями
    func createDebtsDictionary(coming: SbisShortComingListResponse) -> [String: Contractor] {
        var contractorsDictionary: [String: Contractor] = [:]
        for document in coming.result.document {
            if (contractorsDictionary[document.counterparty.companyDetails.INN] == nil) {
                var contractor = Contractor(inn: document.counterparty.companyDetails.INN)
                contractor.debt += Double(document.summ) ?? 0
                contractorsDictionary[contractor.inn] = contractor
            } else {
                contractorsDictionary[document.counterparty.companyDetails.INN]?.debt += Double(document.summ) ?? 0
            }
        }
        print(contractorsDictionary)
        return contractorsDictionary
    }
    
    //MARK: - Создаем выписку по выбранному диапазону времени
    func initStatement(jwt: String, accountId: String, startDateTime : String, endDateTime : String) {
        var accountIDLocal = accountId
        if accountIDLocal.count < 22 {
            accountIDLocal += "/044525999"
        }
        let initStatemenrRequest = TochkaInitStatementRequest(
            JWT: jwt,
            accountID: accountIDLocal,
            startDateTime: startDateTime,
            endDateTime: endDateTime)
        tochkaAPIService.initStatement(initStatemenrRequest) { result in
            switch result {
            case .success(let response):
                print(self.paymentRequestArray)
                print(response.data?.statement.status ?? "status of request not found")
                guard let statementId = response.data?.statement.statementID else {
                    print("statementIs not found")
                    return
                }
                let getStatementRequest = TochkaGetStatementRequest(statementId: statementId, accountId: accountId+"/044525999", jwt: jwt)
                self.getStatement(getStatementRequest)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Запрашиваем конкретную выписку с транзакциями по счету, созданную в initStatement
    func getStatement(_ request: TochkaGetStatementRequest) {
        self.tochkaAPIService.getStatement(request) { result in
            switch result {
            case .success(let responce):
                if responce.data?.statement.first?.transaction == nil {
                    sleep(1)
                    self.getStatement(request)
                } else {
                    if self.statement?.data == nil {
                        self.statement = responce
                    } else if let newTransactions = responce.data?.statement.first?.transaction {
                        self.statement?.data?.statement[0].transaction! += newTransactions
                    } else {
                        print("no transaction in response GetStatement")
                    }
                    self.fillPaymentRequestArray(jwt: request.jwt, accountId: request.accountId)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    //MARK: - Функция отправки запроса о создании платежа на подпись
    func createPaymentForSign(_ paymentRequest: TochkaPaymentForSignRequest) {
        tochkaAPIService.createPaymentForSign(paymentRequest) { result in
            switch result {
            case .success(let response):
                self.debtDict.removeValue(forKey: paymentRequest.body.data.counterpartyINN)
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fillPaymentRequestArray(jwt: String, accountId: String) {
        if paymentRequestArray.isEmpty {
            for debt in debtDict {
                if var request = findPayment(key: debt.key) {
                    request.body.data.paymentNumber = String(paymentRequestArray.count + 1)
                    request.body.data.paymentAmount = String(debt.value.debt)
                    paymentRequestArray.append(request)
                    debtDict.removeValue(forKey: debt.key)
                }
            }
        }

        if !debtDict.isEmpty {
            tryCreatePaymentRequest(jwt: jwt, accountId: accountId)
        } else if !paymentRequestArray.isEmpty {
            print("all payments was created")
            print(paymentRequestArray)
        } else {
            print("there is nothing to pay")
        }
    }
    
    
    func tryCreatePaymentRequest(jwt: String, accountId: String) {
        if statement?.data == nil {
            let lastDateOfPeriod = currentDate()
            let firstDate = dateMinusSomeDays(lastDateOfPeriod: lastDateOfPeriod, periodSize: 20)
            initStatement(jwt: jwt, accountId: accountId, startDateTime: firstDate, endDateTime: lastDateOfPeriod)
        } else {
            for debt in debtDict {
                guard let transaction = findTransaction(debt.key, statement: statement) else { continue }
                let request = createTochkaPaymentForSignRequest(
                    jwt: jwt,
                    debt.key,
                    debt: String(debt.value.debt),
                    transaction: transaction,
                    paymentNumber: String(paymentRequestArray.count + 1)
                )
                paymentRequestArray.append(request)
                debtDict.removeValue(forKey: debt.key)
            }
            if !debtDict.isEmpty {
                guard let lastDateOfPeriod = statement?.data?.statement.first?.transaction?.last?.documentProcessDate else {
                    print ("not date found in last element of [transaction]")
                    return
                }
                let firstDate = dateMinusSomeDays(lastDateOfPeriod: lastDateOfPeriod, periodSize: 4)
                initStatement(jwt: jwt, accountId: accountId, startDateTime: firstDate, endDateTime: lastDateOfPeriod)
            } else {
                print(paymentRequestArray)
            }
            
        }
    }

    func findPayment(key: String) -> TochkaPaymentForSignRequest? {
        var request: TochkaPaymentForSignRequest?
        self.keychainService.fetchTochkaPaymentForSignRequest(key: key) { result in
            switch result {
            case .success(let response):
                request =  response
            case .failure(let error):
                request = nil
                print(error)
            }
        }
        return request
    }
    //MARK: - ищет транзакцию по счету для указанного ИНН
    func findTransaction(_ inn: String, statement: TochkaGetStatementResponse?) -> Transaction? {
        guard let transactions = statement?.data?.statement.first?.transaction  else { return nil }
        for transaction in transactions {
            if inn == transaction.creditorParty?.inn {
                return transaction
            }
        }
        return nil
    }
    
    //MARK: - Создатель реквестов платежа по ИНН и транзакции
    private func createTochkaPaymentForSignRequest(jwt: String, _ inn: String, debt: String, transaction: Transaction, paymentNumber: String) -> TochkaPaymentForSignRequest {
        let request = TochkaPaymentForSignRequest(
            jwt: jwt,
            body: TochkaPaymentForSignBodyRequest(
                data: DataClasPaymentForSign(
                    accountCode: "40702810501500049085",
                    bankCode: "044525999",
                    counterpartyBankBic: transaction.creditorAgent!.identification,
                    counterpartyAccountNumber: transaction.creditorAccount!.identification,
                    counterpartyINN: inn,
                    counterpartyName: transaction.creditorParty!.name,
                    paymentAmount: debt,
                    paymentDate: currentDate(),
                    paymentNumber: paymentNumber,
                    paymentPurpose: transaction.transactionDescription)))
        
        return request
    }
    
    //MARK: - Возвращает текущую дату в формате ISO8601
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func dateMinusSomeDays(lastDateOfPeriod: String, periodSize: Int) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let lastDateOfPeriodLikeDate = dateFormater.date(from: lastDateOfPeriod) ?? Date()
        let firstDateOfPeriodLikeDate = Calendar.current.date(byAdding: .day, value: -periodSize, to: lastDateOfPeriodLikeDate) ?? Date()
        return dateFormater.string(from: firstDateOfPeriodLikeDate)
    }
}

extension PaymentViewPresenter: PaymentViewPresenterProtocol {
    func viewDidLoad() {
        checkJWT()
        
        //TODO: не забудь убрать delete
        keychainService.deleteItem(for: .lastPaymentDate)
        guard let lastPaymentDate = keychainService.fetch(for: .lastPaymentDate) else {
            print(keychainService.save("2022-12-05", for: .lastPaymentDate))
            return
        }
    }
    
    func payOffDebtButtonDidPressed() {
        guard let jwt = self.keychainService.fetch(for: .tochkaJWT), let accountId = self.keychainService.fetch(for: .tochkaAccountID) else {
            self.showJWTViewController()
            return
        }
        let endDateTime = currentDate()
        let startDateTime = keychainService.fetch(for: .lastPaymentDate) ?? "2022-12-01"
//        DispatchQueue.global().async {
//            self.paymentRequestConstructor(jwt: jwt, accountId: accountId, startDateTime: startDateTime, endDateTime: endDateTime)
//        }
        
        print("test12")
    }
}


extension PaymentViewPresenter: PaymentViewPresenterDataSource {
    func updateModel(_ documents: SbisShortComingListResponse) {
        debtDict = self.createDebtsDictionary(coming: documents)
    }
}






//useless code

//    //MARK: - создает лист разрешений - то какие методы может обрабатывать сервер по ауф данным
//    private func createPermissionList() {
//        guard let accessToken = self.keychainService.fetch(for: .tochkaAccessToken) else {
//            print("fetch access token from keychainService error")
//            return
//        }
//        let request = TochkaPermissionsListRequest(accessToken)
//        tochkaAPIService.createPermissionsList(request) { result in
//            switch result {
//            case .success(let responce):
//                print(responce)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    //MARK: - запрашивает accessToken по clientID и clientSecret, осхраняет его в keychain
//    private func accessTokenRequest() {
//        let request = TochkaAccessTokenRequest(" ", clientSecret: " ")
//        tochkaAPIService.getAccessToken(request) { [weak self] result in
//            switch result {
//            case .success(let responce):
//                if let tochkaAccessToken = responce.accessToken {
//                    self?.keychainService.save(tochkaAccessToken, for: .tochkaAccessToken)
//                    self?.createPermissionList()
//                } else {
//                    print(responce.errorDescription ?? "unexpected error")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

