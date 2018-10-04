//
//  Injector.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/2/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation

public class Injector {
    public class func provideLoginPresenter() -> LoginPresenter {
        return LoginPresenter(repository: Injector.provideLoginRepository())
    }
    
    public class func provideLoginRepository() -> LoginRepository {
        return LoginRepository()
    }
    
    public class func provideForgetPasswordPresenter() -> ForgetPasswordPresenter {
        return ForgetPasswordPresenter(repository: Injector.provideForgetPasswordRepository())
    }
    
    public class func provideForgetPasswordRepository() -> ForgetPasswordRepository {
        return ForgetPasswordRepository()
    }
}
