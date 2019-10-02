#!/bin/bash

APPIPA=LoanCalc.ipa
TESTIPA=LoanCalcUITests-Runner.ipa
DEVICE=iPhone_6S_carrier_test_sjc

#runner.sh config --path runner.yml --apikey ${LOANCALC_IOS_APIKEY} $*
runner.sh xcuitest --test ${TESTIPA} --app ${APPIPA} --apikey ${LOANCALC_IOS_APIKEY} --datacenter US --device ${DEVICE} --testsToRun LoanCalcUITests/testLoanCalc1,LoanCalcUITests/testLoanCalc2 $*
