#!/opt/anaconda3/bin/python
# Called at 9:00am every Monday
from emailing import send_email
from datetime import datetime, timedelta
from util import report_dir
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from typing import List
import os


def get_latest_traffic(duration_days:int, freq:str):
    _end = datetime.now()
    _start = _end - timedelta(days=duration_days)

    # load the traffic data
    _file_name = report_dir+"traffic_record_" + _end.strftime("%Y_%m") +".csv"
    records = pd.read_csv(_file_name, header=[0,1], index_col=0)
    if _start.month != _end.month:
        # load data of the previous month
        _file_name = report_dir+"traffic_record_" + _start.strftime("%Y_%m") +".csv"
        records_pre = pd.read_csv(_file_name, header=[0,1], index_col=0)
        records = pd.concat([records_pre, records])
    
    # pick the recording items
    # refer to: https://stackoverflow.com/a/29370182/11659389
    records.index = pd.to_datetime(records.index)
    mask = records.index > _start
    items = records.loc[mask]
    # items.groupby(items['date'])

    # items = items.set_index('date')

    # refer to https://towardsdatascience.com/how-to-group-data-by-different-time-intervals-using-python-pandas-eb7134f9b9b0
    # and https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.resample.html
    return items.resample(freq).sum() 


def create_visibility_array(fig, traffic_type):
    """
    Returns array of boolean values representing the
    visibility array of figure traces. Traces with the 
    same meta value as 'traffic_type' are set to 'True'.
    """

    return [True if trace['meta']['traffic_type'] == traffic_type 
            else False for trace in fig['data']]


def create_buttons(fig, button_label:List[str]):
    """Returns list of button objects."""
    
    button_list = []
    for lbl in button_label:
        ref_button = dict(
            label=lbl, 
            method="restyle",
            args=[dict(
                visible=create_visibility_array(fig, lbl))]
        )
        button_list.append(ref_button)
    return button_list


# Swap function
def swapPositions(list, pos1, pos2):
    list[pos1], list[pos2] = list[pos2], list[pos1]
    return list


def add_total_column(data, new_column_name='total'):
    _sum = data.swaplevel(axis=1)['others'] + data.swaplevel(axis=1)['tcp_without_payload']
    _sum.columns = pd.MultiIndex.from_product([_sum.columns, [new_column_name]])
    return data.join(_sum)

if __name__ == "__main__":
    # print(datetime.now().strftime("%Y%m%d"))

    # refer to: https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html#dateoffset-objects
    freq_hour = 'H'
    freq_day = 'D'

    data_7_days = get_latest_traffic(7, freq_hour)
    data_30_days = get_latest_traffic(30, freq_day)

    # add a 'total' column
    data_7_days = add_total_column(data_7_days)
    data_30_days = add_total_column(data_30_days)

    button_label = list(data_7_days.columns.levels[1])
    swapPositions(button_label, 0, 1)

    # plot traffic of latest 7 days
    # https://towardsdatascience.com/how-to-make-multi-index-index-charts-with-plotly-4d3984cd7b09
    fig_7_days = go.Figure()
    for traffic_type in data_7_days.columns.levels[1]:
        for user in data_7_days.columns.levels[0]:
            fig_7_days.add_scatter(
                x=data_7_days.index,
                y=data_7_days[user, traffic_type],
                name=user,
                meta=dict(traffic_type=traffic_type)
            )
    fig_7_days.update_layout(
        updatemenus=[dict(buttons=create_buttons(fig_7_days, button_label))],
        title='Hourly Server-to-Cloud Traffic in the past 7 days',
        yaxis_title='Byte'
    )
    # hide traces on initialization, by default all traces are shown
    fig_7_days.update_traces(visible=False)
    fig_7_days.update_traces(
        visible=True, 
        selector=dict(meta={'traffic_type':button_label[0]})
        )
    

    # plot the interactive/sortable table


    # plot traffic of latest 30 days
    fig_30_days = go.Figure()
    for traffic_type in data_30_days.columns.levels[1]:
        for user in data_30_days.columns.levels[0]:
            fig_30_days.add_scatter(
                x=data_30_days.index,
                y=data_30_days[user, traffic_type],
                name=user,
                meta=dict(traffic_type=traffic_type)
            )
    fig_30_days.update_layout(
        updatemenus=[dict(buttons=create_buttons(fig_30_days, button_label))],
        title='Daily Server-to-Cloud Traffic in the past 30 days',
        yaxis_title='Byte'
    )
    # hide traces on initialization, by default all traces are shown
    fig_30_days.update_traces(visible=False)
    fig_30_days.update_traces(
        visible=True, 
        selector=dict(meta={'traffic_type':button_label[0]})
        )

    # plot the interactive/sortable table
    
        

    # generate the html
    # https://stackoverflow.com/a/59869358/11659389
    file_timestamp = datetime.today()
    file_name = "traffic_report_" + file_timestamp.strftime("%Y_%m_%d") +".html"
    file_full_path = report_dir+"graphs"+os.sep+file_name
    with open(file_full_path, 'w') as f:
        f.write(fig_7_days.to_html(full_html=False, include_plotlyjs='cdn'))
        f.write(fig_30_days.to_html(full_html=False, include_plotlyjs='cdn'))


    # email
    receivers = [
        "hmmeng@se.cuhk.edu.hk",
        "khwong@se.cuhk.edu.hk",
        "wkleung@se.cuhk.edu.hk", 
        "tristan_wyl@cuhk.edu.hk"]
    title = "[NO REPLY] Weekly Report of the Network Traffic of the TBS GPU Server"
    content = "Please open the .html file attached with a browser. For well loading the html file, an active internet connection is required."
    send_email(receivers, title, content, file_full_path)


