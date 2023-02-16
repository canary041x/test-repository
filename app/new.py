import requests
from jira import JIRA
from jira.exceptions import JIRAError
import ast # 追記★
from urllib import request

def lambda_handler(event, context):
    url = 'https://example.com'
    res = req(url)
    return {
        'url': url,
        'res': res,
    }

def req(url):
    get_req = request.Request(url)
    with request.urlopen(get_req) as res:
        body = res.read()
        return body