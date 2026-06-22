import csv
import glob
import os
import pydot
import statistics


def count_across_nodes(graph: pydot.Graph, key_type: str) -> int:
    return [ True if key_type in n.obj_dict['attributes']['label'] else False for n in graph.get_nodes() ].count(True)

def count_across_edges(graph: pydot.Graph, lock_type: str) -> int:
    return [ True if lock_type in n.obj_dict['attributes']['label'] else False for n in graph.get_edges() ].count(True)

def node_out_rank(graph: pydot.Graph, node: pydot.Node) -> int:
    return [ True if node.get_name() == e.get_source() else False for e in graph.get_edges()].count(True)

def avg_node_out_rank(graph: pydot.Graph) -> float:
    return statistics.mean([ node_out_rank(graph, n) for n in graph.get_nodes() ])


def level_dot_to_dict(game: str, path: str) -> dict:
    graph = pydot.graph_from_dot_file(path)[0]

    res = {
        "game" : game,
        "number_nodes" : len(graph.get_nodes()),
        "number_edges" : len(graph.get_edges()),
        "number_normal_keys" : count_across_nodes(graph, 'k'),
        "number_boss_keys": count_across_nodes(graph, 'K'),
        "number_key_items": count_across_nodes(graph, 'I'),
        "number_switches" : count_across_nodes(graph, 'S'),
        "number_normal_locks": count_across_edges(graph, 'k'),
        "number_boss_locks": count_across_edges(graph, 'K'),
        "number_key_item_locks": count_across_edges(graph, 'I'),
        "number_switch_locks": count_across_edges(graph, 'S'),
        "avg_out_rank" : avg_node_out_rank(graph),
    }

    return res

GAME_DIRS = [
    "The Legend of Zelda",
    "The Legend of Zelda - Link to the Past",
    "The Legend of Zelda - Link's Awakening"
]


data = []

for game in GAME_DIRS:
    data_dir = os.path.join('data', game)
    dot_file_paths = glob.glob(f'{data_dir}/**.dot')
    
    
    for path in dot_file_paths:
        data.append(level_dot_to_dict(game, path))

with open("zelda_data.csv", "w", newline="") as f:
    w = csv.DictWriter(f, [
        'game',
        'number_nodes',
        'number_edges',
        'number_normal_keys',
        'number_boss_keys',
        'number_key_items',
        'number_switches',
        'number_normal_locks',
        'number_boss_locks',
        'number_key_item_locks',
        'number_switch_locks',
        'avg_out_rank'
    ])
    w.writeheader()
    w.writerows(data)
