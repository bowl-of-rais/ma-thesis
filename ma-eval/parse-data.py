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
    's_iss_miro',
    's_tp_miro',
    's_fp_miro',
    's_iss_pixie',
    's_tp_pixie',
    's_fp_pixie',
    'p_ans_miro',
    'p_ans_pixie',
    'p_right_miro',
    'p_right_pixie',
    's_sob_miro',
    's_sob_pixie'
]

with open("protocol-data.csv", "w", newline="") as f:
    w = csv.DictWriter(f, DATA_KEYS)
    w.writeheader()
    for d in data:
        w.writerow(d)

QUESTIONNAIRE_DATA_KEYS = [
    "Timestamp",
    "Participant ID",
    "Age",
    "Gender",
    "Education (study course and whether its ongoing)",
    "Education Codified",
    "Occupation:",
    "Number of projects/games you worked on (rough estimate)",
    "Projects Codified",
    "Experience with digital whiteboards (e.g. Miro, Figjam)",
    "Whiteboard Experience Codified",
    "Experience with game design tools (e.g. Arcweave)",
    "Game Design Tool Experience Codified",
    "Relevant Background (anything not covered by the other questions):",
    "SUS-1",
    "SUS-2",
    "SUS-3",
    "SUS-4",
    "SUS-5",
    "SUS-6",
    "SUS-7",
    "SUS-8",
    "SUS-9",
    "SUS-10",
    "FQ1",
    "UEQS-1",
    "UEQS-2",
    "UEQS-3",
    "UEQS-4",
    "UEQS-5",
    "UEQS-6",
    "UEQS-7",
    "UEQS-8",
    "C-Q1",
    "C-Q2",
    "C-Q3",
    "C-Q4",
    "FQ2"
]

combined_data = []
with open('questionnaire-responses-preprocessed.csv', newline='') as questionnaire_data:
    reader = csv.DictReader(questionnaire_data)
    for row in reader:
        matching_protocol = next(item for item in data if item["p_id"] == row["Participant ID"])
        merged_row = row | matching_protocol
        combined_data.append(merged_row)

with open("combined-data.csv", "w", newline="") as f:
    w = csv.DictWriter(f, DATA_KEYS + QUESTIONNAIRE_DATA_KEYS)
    w.writeheader()
    for d in combined_data:
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
feedback_data = []
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
            'pacing_miro': [],
        }
        
        current_heading = ''

        timestamp_re = r'^(0[0-1]|1[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]'
        for line in lines:
            print(line)
            if line.startswith('####'):
                current_heading = line.removeprefix('#### ')
                print(current_heading)

            elif current_heading != 'feedback_comments_observations' and re.match(timestamp_re, line):
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

            elif current_heading == 'feedback_comments_observations' and line.strip():
                tag = line[0:3]
                note = line[4:]

                feedback_data.append({
                    'p_id' : metadata['p_id'],
                    'group' : metadata['group'],
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

DATA_KEYS_FEEDBACK = [
    'p_id',
    'group',
    'tag',
    'note'
]

with open(f'feedback_comments_observations.csv', "w", newline="") as f:
    w = csv.DictWriter(f, DATA_KEYS_FEEDBACK)
    w.writeheader()
    for d in feedback_data:
        w.writerow(d)

    # count += 1

