#Import necessary packages
import io
import re
import time
import os

import pandas
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
from google.oauth2 import service_account
import google.auth.transport.requests


#Create Flask App and expose initialize using CORS
app = Flask(__name__)
CORS(app)
api = Api(app)

#Initialize RequestParser to receive api post request variables
parser = reqparse.RequestParser()
parser.add_argument("user_id")
parser.add_argument("fcm")

#Initialize Flask app with firebase_admin and set variable cred (used for push notification authorization)
cred = credentials.Certificate("FILE PATH")
firebase_admin.initialize_app(cred)
print(cred)



#new dataframe, row1: user email, fcm token, and then soccer, other sports
#if user .isin "user email" column, then return [false, true, true, false]
#else .add user, false, false, false, false

#Flutter side:

#Returns access token to authorize Firebase push notification
def _get_access_token():
    SCOPES = []
    SCOPES.append("https://www.googleapis.com/auth/firebase.messaging")
    credentials = service_account.Credentials.from_service_account_file(
        'FILE PATH', scopes=SCOPES)
    request = google.auth.transport.requests.Request()
    credentials.refresh(request)
    return credentials.token

#Receive FCM Token and User information from Flutter App to return associated club information
@app.route("/stuysports1", methods=['GET', 'POST'])
def home():
    print("API Hit")
    time.sleep(2)
    if request.method == "POST":
        user = request.form.get("val")
        print(user)
        deviceToken = request.form.get("fcm")
        print(deviceToken)
        headers = {
            'Authorization': 'Bearer ' + _get_access_token(),
            'Content-Type': 'application/json; UTF-8',
        }
        body = {
           "message":{
              "token": deviceToken,
              "notification":{
                "body":"This is an FCM notification message!",
                "title":"FCM Message"
              }
           }
        }
        response = requests.post("https://fcm.googleapis.com/v1/projects/stuy-sports/messages:send", headers=headers, data=json.dumps(body))
        print(response.status_code)
        print(response.json())
    return ["soccer", "true", "basketball", "false"]

#Receive FCM Token and User information from Flutter App to return associated club information
@app.route("/stuysports2", methods=['GET', 'POST'])
def initial_setup():
    print("API Hit")
    time.sleep(2)
    if request.method == "POST":
        user = request.form.get("val")
        print(user)
    return [False, True, True, False]

if __name__ == "__main__":
    serve(app, host="192.168.1.170", port=5001)
