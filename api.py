#Import necessary packages
import io
import re
import time
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from bs4 import BeautifulSoup
import numpy as np
import json
import requests
from urllib.request import urlopen
from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from flask import Flask, render_template, request, redirect, session, jsonify
from flask_cors import CORS
from flask_restful import Api, Resource, reqparse
from waitress import serve
import firebase_admin
from firebase_admin import credentials
from google.auth import exceptions,jwt
from googleapiclient import discovery
from google.oauth2.service_account import Credentials

#Access PSAL database to extract game schedules (example below uses Stuyvesant Boys Varsity Soccer Team)
chrome_options = Options()
chrome_options.add_argument("--headless")
driver = webdriver.Chrome(options=chrome_options)
start_url = "https://www.psal.org/profiles/team-profile.aspx#012/02519"
driver.get(start_url)
time.sleep(2)
print(driver.page_source.encode("utf-8"))
element2 = driver.find_elements(By.XPATH, '//*[@id="tab1"]/table/tbody')
i=0
temp = ""
for value2 in element2:
    i+=1
    if i<2:
        print(i)
        temp = value2.text

temp_new = temp.split("\n")[1:]
i = 0
j = len(temp_new) - 1
new_list = []
while i < j:
    new_str = temp_new[i] + temp_new[i + 1]
    new_list.append(new_str)
    i += 2
elem = new_list[0]
print(elem)
# Game_ID = re.findall(r"\D(\d{5})\D", elem)
# print(Game_ID)
# Date = re.findall(r"^([1-9] |1[0-9]| 2[0-9]|3[0-1])(.|/)([1-9] |1[0-2])(.|/|)20[0-9][0-9]$",elem)
# Time = re.findall(r'(\d{1,2})([.:](\d{1,2}))?[ ]?(am|pm)?', elem)
driver.quit()
print("Done")

app = Flask(__name__)
CORS(app)
api = Api(app)

parser = reqparse.RequestParser()
parser.add_argument("val")

cred = credentials.Certificate("C:/user/folder/service-account.json") #set appropriate file path for service-account.json file
firebase_admin.initialize_app(cred)
print(cred)

def _get_access_token():
    SCOPES = []
    SCOPES.append("https://www.googleapis.com/auth/firebase.messaging")
    credentials = firebase-adminsdk.Credentials.from_service_account_file(
        'C:/user/folder/service-account.json', scopes=SCOPES) #set appropriate file path for service-account.json file
    request = google.auth.transport.requests.Request()
    credentials.refresh(request)
    return credentials.token

@app.route("/stuyactivities1", methods=['GET', 'POST'])
def main():
    print("API Hit")
    time.sleep(2)
    if request.method == "POST":
        user = request.form.get("val")
        print(user)
        deviceToken = request.form.get("fcm")
        print(deviceToken)
        # headers = {
        #     'Content-Type': 'application/json',
        #     'Authorization': 'key=' + serverToken,
        # }
        #
        # body = {
        #     'notification': {'title': 'Sending push form python script',
        #                      'body': 'New Message'
        #                      },
        #     'to':
        #         deviceToken,
        #     'priority': 'high',
        #     #   'data': dataPayLoad,
        # }
        # response = requests.post("https://fcm.googleapis.com/v1/projects/stuy-app-820c4/messages:send", headers=headers, data=json.dumps(body))
        # print(response.status_code)
        # print(response.json())
    return "Python says hello"

@app.route("/stuyactivities2", methods=['GET', 'POST'])
def main():
    print("API Hit")
    time.sleep(2)
    if request.method == "POST":
        team_name = request.form.get("val")
        print(team_name)
        deviceToken = request.form.get("fcm")
        print(deviceToken)
    return "Python says hello"

if __name__ == "__main__":
    serve(app, host="192.168.1.170", port=5001)

