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
    
    public class func provideAvatarPresenter() -> AvatarPresenter {
        return AvatarPresenter(repository: Injector.provideAvatarRepository())
    }
    
    public class func provideAvatarRepository() -> AvatarRepository {
        return AvatarRepository()
    }
    
    public class func provideProgramRepository() -> ProgramRepository{
        return ProgramRepository()
    }
    
    public class func provideProgramPresenter() -> ProgramPresenter {
        return ProgramPresenter(repository: Injector.provideProgramRepository())
    }
    
    public class func provideProjectPagerPresenter() -> ProjectPagerPresenter {
        return ProjectPagerPresenter(repository: Injector.provideProjectPageRepository())
    }
    
    public class func provideProjectPageRepository() -> ProjectPageRepository {
        return ProjectPageRepository()
    }
    
    public class func provideWeekDetailsPresenter() -> WeekDetailsPresenter {
        return WeekDetailsPresenter(repository: Injector.provideWeekDetailsRepository())
    }
    
    public class func provideWeekDetailsRepository() -> WeekDetailsRepository {
        return WeekDetailsRepository()
    }
    
    public class func provideWeekVisionRepository() -> WeekVisionRepository {
        return WeekVisionRepository()
    }
    
    public class func provideWeekVisionPresenter() -> WeekVisionPresenter {
        return WeekVisionPresenter(repository: Injector.provideWeekVisionRepository())
    }
    
    public class func provideMilestonesRepository() -> MilestonesRepository {
        return MilestonesRepository()
    }
    
    public class func provideMilestonesPresenter() -> MilestonePresenter {
        return MilestonePresenter(repository: Injector.provideMilestonesRepository())
    }
}
