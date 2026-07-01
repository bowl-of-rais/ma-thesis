import csv
from datetime import datetime
import frontmatter
import glob
from pprint import pprint
import re


DATA_PATH = '../ma-notes/07-evaluation/user-study-data'

files = glob.glob(f'{DATA_PATH}/**.md')

# ======================================== Frontmatter Data ==========================================

data = []
for path in files:
    with open(path) as f:
        metadata, content = frontmatter.parse(f.read())
        data.append(metadata)

# pprint(data)

DATA_KEYS = [
    'participant',
    'p_id',
    'date',
    'group',
    's_issues_miro',
    's_issues_pixie',
    's_issues_correct_miro',
    's_issues_correct_pixie',
    'p_answered_miro',
    'p_answered_pixie',
    'p_answered_correct_miro',
    'p_answered_correct_pixie'
]

with open("eval-data.csv", "w", newline="") as f:
    w = csv.DictWriter(f, DATA_KEYS)
    w.writeheader()
    for d in data:
        w.writerow(d)


# ======================================== Time-Series Data ==========================================

DATA_KEYS_2 = [
    'p_id',
    'group',
    'task',
    'map',
    'timestamp',
    'tag',
    'note',
    'timedelta'
]

MAPS = {
    'AM': {
        'solvability_pixie': 'LA_4',
        'solvability_miro': 'LA_3',
        'pacing_pixie': 'LA_2',
        'pacing_miro': 'LA_1'
    },
    'AP': {
        'solvability_pixie': 'LA_3',
        'solvability_miro': 'LA_4',
        'pacing_pixie': 'LA_1',
        'pacing_miro': 'LA_2'
    },
    'BM': {
        'solvability_pixie': 'LA_3',
        'solvability_miro': 'LA_4',
        'pacing_pixie': 'LA_1',
        'pacing_miro': 'LA_2'
    },
    'BP': {
        'solvability_pixie': 'LA_4',
        'solvability_miro': 'LA_3',
        'pacing_pixie': 'LA_2',
        'pacing_miro': 'LA_1'
    }
}

def get_map(heading: str, group: str) -> str:
    return MAPS[group][heading]

time_fmt = '%H:%M:%S'

time_series_data = []
count = 0
for path in files:
    print(f'parsing {path}')
    #if count > 0:
    #    break
    with open(path) as f:
        metadata, content = frontmatter.parse(f.read())

        lines = content.splitlines()

        file_data = {
            'solvability_pixie': [],
            'solvability_miro': [],
            'pacing_pixie': [],
            'pacing_miro': []
        }
        
        current_heading = ''

        timestamp_re = r'^(0[0-1]|1[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]'
        for line in lines:
            print(line)
            if line.startswith('####'):
                current_heading = line.removeprefix('#### ')
                print(current_heading)

                if current_heading == 'General Feedback':
                    break

            elif re.match(timestamp_re, line):
                print('match found')
                timestamp = line[0:8]
                tag = line[9:12]
                note = line[13:]

                file_data[current_heading].append({
                    'p_id' : metadata['p_id'],
                    'group' : metadata['group'],
                    'task' : current_heading,
                    'map' : get_map(current_heading, metadata['group']),
                    'timestamp' : timestamp,
                    'tag' : tag,
                    'note' : note, 
                })

        for mode, series in file_data.items():
            if (len(series) == 0):
                pprint(series)
                continue
            start_time = datetime.strptime(series[0]['timestamp'], time_fmt)

            with open(f'time_series/{metadata['p_id']}/{mode}.csv', "w", newline="") as f:
                w = csv.DictWriter(f, DATA_KEYS_2)
                w.writeheader()
                for d in series:
                    d['timedelta'] = (datetime.strptime(d['timestamp'], time_fmt) - start_time).seconds
                    w.writerow(d)

            time_series_data += series

        pprint(file_data)

with open(f'time_series/all.csv', "w", newline="") as f:
    w = csv.DictWriter(f, DATA_KEYS_2)
    w.writeheader()
    for d in time_series_data:
        w.writerow(d)


    # count += 1

