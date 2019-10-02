//
//  CucumberishLoader.m
//  LoanCalcUITests
//
//  Created by Erik James on 9/24/19.
//  Copyright © 2019 Bill Meyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanCalcUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit()
{
    [CucumberishInitializer CucumberishSwiftInit];
}
