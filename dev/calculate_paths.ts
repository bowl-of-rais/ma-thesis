import { testNodes, testEdges } from './test_elements.js'
import { dijkstra_path } from './dijkstra.js'


function test_two_nodes_with_path() {
    console.log('TEST: two nodes, path exists');
    let start = '1';
    let end = '5';

    const t1 = new Date().getTime();

    let path = dijkstra_path(testNodes, testEdges, start, end);

    let elapsed = new Date().getTime() - t1;

    console.log(path);
    console.log(`Time: ${elapsed}\n\n`);
}

function test_two_nodes_no_path() {
    console.log('TEST: two nodes, path does not exist');
    let start = '2';
    let end = '3';

    const t1 = new Date().getTime();

    let path = dijkstra_path(testNodes, testEdges, start, end);

    let elapsed = new Date().getTime() - t1;

    console.log(path);
    console.log(`Time: ${elapsed}\n\n`);
}


// -------------------------------------------------------------------------------------------

test_two_nodes_with_path();
test_two_nodes_no_path();
