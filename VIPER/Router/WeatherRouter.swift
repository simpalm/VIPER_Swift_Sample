//
//  WeatherRouter.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation
import UIKit

class WeatherRouter: PresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController;
        
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = WeatherPresenter();
        let interactor: PresentorToInterectorProtocol = WeatherInterecter();
        let router: PresenterToRouterProtocol = WeatherRouter();
        view?.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        
        return view!;
        
        //}
        //return UIViewController()
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
