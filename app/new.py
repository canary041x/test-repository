import requests
from jira import JIRA
from jira.exceptions import JIRAError
import os # 追記★
import ast # 追記★


def send_slack(message, CHANNEL):
    TOKEN = 'xoxb-946744aaa-457282512aaa-aaaaaa'

    url = "https://slack.com/api/chat.postMessage"
    headers = {"Authorization": "Bearer "+TOKEN}
    data  = {
       'channel': CHANNEL,
       'text': message
    }
    r = requests.post(url, headers=headers, data=data)
    print("return ", r.json())

# JIRA
def lambda_handler(event, context):
    options = {'server': 'https://jira.arms.dmm.com'}
    usr = 'c-sd-aaa'
    pas = 'nTqyaaa'
    try:
        jira = JIRA(options=options, basic_auth=(usr, pas))
    except JIRAError as e:
        logging.info(e)
        
    # 下記の3行は削除★
    # work_list = {
    #     'test-sec-alert' : 'project = SECALERT AND labels = "Group" AND duedate < now() AND status = "To Do" ORDER BY updated DESC',
    # }

    work_list = ast.literal_eval(os.environ["work_list"]) # 追記★
    
    for CHANNEL in work_list:
        all_proj_issues_but_mine = jira.search_issues(work_list[CHANNEL])
        if all_proj_issues_but_mine:
            message = 'いつもご協力頂きありがとうございます。\n以下、対応期限が切れているチケットのご確認お願いいたします。\n\n{}件\nhttps://jira.aaa.com/browse/{}\n\n期限内に対応が難しい場合は、期限をお願いします。'.format(len(all_proj_issues_but_mine), all_proj_issues_but_mine[0].key)
            send_slack(message, CHANNEL)
            print(message)
        else:
            print('未完了タスクはありません')