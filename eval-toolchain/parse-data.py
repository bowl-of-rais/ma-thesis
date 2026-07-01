import csv
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
    'timestamp',
    'tag',
    'note'
]

time_series_data = []
count = 0
for path in files:
    if count > 0:
        break
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
            if line.startswith('####'):
                current_heading = line.removeprefix('#### ')
                #print(current_heading)

                if current_heading == 'General Feedback':
                    break

            elif re.match(timestamp_re, line):
                timestamp = line[0:8]
                tag = line[9:12]
                note = line[13:]

                file_data[current_heading].append({
                    'timestamp' : timestamp,
                    'tag' : tag,
                    'note' : note,
                })

        for mode, series in file_data.items():
            with open(f'time_series/{metadata['p_id']}/{mode}.csv', "w", newline="") as f:
                w = csv.DictWriter(f, DATA_KEYS_2)
                w.writeheader()
                for d in series:
                    w.writerow(d)

        pprint(file_data)

        # time_series_data.append(ast_dict)
    count += 1

