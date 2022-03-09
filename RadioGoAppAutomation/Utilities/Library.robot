*** Settings ***
Documentation     Suite description
Library           Collections
Library           JSONLibrary
Library           String
Library           OperatingSystem
Library           RequestsLibrary
Library           Python/Utils.py
#Library           Python/OCR.py
Library           AppiumLibrary
Library           DateTime
Resource          ../Config/common_variables.robot    #Input required by Engineer to run the Automation scripts
Resource          UI_keywords.robot
Resource          RadioGoTestSetup.robot
#Library          RabbitMq
#Library          DatabaseLibrary
Resource          API_keywords.robot
Resource          ../Config/API_end_ponts.robot
Resource          Messages.robot
Resource          ../Config/var.robot
