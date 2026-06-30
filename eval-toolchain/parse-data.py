import csv
import frontmatter
import glob
from pprint import pprint

DATA_PATH = '../ma-notes/07-evaluation/user-study-data'

files = glob.glob(f'{DATA_PATH}/**.md')
    
data = []
for path in files:
    with open(path) as f:
        metadata, content = frontmatter.parse(f.read())
        data.append(metadata)

pprint(data)

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

