// Validate Binary Search Tree

const isValidBST = function(root, prev = null, side = null) {
    if (!root) return true;
    if (side === "left" && root.val > prev.val) return false;
    if (side === "right" && root.val <= prev.val) return false;
    return isValidBST(root.left, root, "left") && isValidBST(root.right, root, "right")
};

// Symmetric Tree

var isSymmetric = function(root) {
  return isSymetricRecursive(root, root);
};

function isSymetricRecursive(node,reverse) {
  if(node === null && reverse === null) {
    return true; // stillSymmetric
  } else if (node===null || reverse === null){
    return false;
  }

  if(node.val !== reverse.val) return false;

  return isSymetricRecursive(node.left, reverse.right) &&
         isSymetricRecursive(node.right, reverse.left);
}

// Closest Binary Search Tree Value

var closestValue = function(root, target) {
    let child = target < root.val ? root.left : root.right;

    if (!child) return root.val;

    let closest = closestValue(child, target);

    return Math.abs(closest - target) < Math.abs(root.val - target) ? closest : root.val;
};

// Sum root to leaf numbers

var sumNumbers = function(root, val=0) {
    if (!root) return 0;
    else {
        val = val * 10 + root.val
        if (!root.left && !root.right) {
            return val;
        } else {
            return sumNumbers(root.left, val) + sumNumbers(root.right, val);
        }
    }
};

// Construct Maximum Binary Tree

const constructMaximumBinaryTree = (nums, low = 0, high = nums.length - 1) => {
    if (low > high) return null
    let i = low
    for (let j = low + 1; j <= high; j++) {
        if (nums[j] > nums[i]) i = j
    }
    const root = new TreeNode(nums[i])
    root.left = constructMaximumBinaryTree(nums, low, i - 1)
    root.right = constructMaximumBinaryTree(nums, i + 1, high)
    return root
};


// Two Sum Binary Tree

var findTarget = function(root, k) {
    // hash = {};
    arr = inorderTraverse(root);
    // for (let i = 0; i < arr.length; i++) {
    //     if (hash[arr[i]]) return true;
    //     hash[k - arr[i]] = true;
    // }
    // return false;
    let start = 0;
    let end = arr.length - 1;
    while (start < end) {
        let total = arr[start] + arr[end];
        if (total < k) {
            start++
        } else if (total > k) {
            end--
        } else {
            return true;
        }
    }
    return false;
};

const inorderTraverse = (node, arr = []) => {
    if (node === null) return;
    inorderTraverse(node.left, arr);
    arr.push(node.val);
    inorderTraverse(node.right, arr);
    return arr;
}

// Subtree of another tree

var isSubtree = function(s, t) {
    if (s === null && t === null) return true;
    if (s === null || t === null) return false;
    if (isEqualTree(s, t)) return true;
    return isSubtree(s.left, t) || isSubtree(s.right, t);
};

const isEqualTree = (root1, root2) => {
    if (root1 === null && root2 === null) return true;
    if (root1 === null || root2 === null) return false;
    if (root1.val != root2.val) return false;
    return isEqualTree(root1.left, root2.left) && isEqualTree(root1.right, root1.right);
}

// Level Order Traversal
var levelOrder = function(root) {
    let queue = [];
    let result = [];
    queue.push(root);
    while(queue.length > 0) {
        let size = queue.length;
        let current = [];
        for (let i = 0; i < size; i++) {
            let head = queue.shift();
            current.push(head.val);
            if (head.left !== null) {
                queue.push(head.left)
            }
            if (head.right !== null) {
                queue.push(head.right)
            }
        }
        result.push(current);
    }
    return result;
};

// Vertical Order

var verticalOrder = function(root) {
    var res = [];
    if(!root) return res;
    var map = {};
    var q = [[root,0]];
    while(q.length > 0) {
        const cur = q.shift();
        if(!(cur[1] in map)) map[cur[1]] = [];
        map[cur[1]].push(cur[0].val);
        // bfs, add children
        if(cur[0].left) q.push([cur[0].left, cur[1]-1]);
        if(cur[0].right) q.push([cur[0].right, cur[1]+1]);
    }
    Object.keys(map).sort((a,b) => a - b).map((key, i) => res[i] = map[key]);
    return res;
};

// Number of Islands

const search = (i, j, grid) => {
    if (i < 0 || j < 0 ||
        i > grid.length - 1 ||
        j > grid[i].length - 1 ||
        grid[i][j] === '0') {
        return;
    }
    grid[i][j] = '0';
    search(i - 1, j, grid);
    search(i, j - 1, grid);
    search(i + 1, j, grid);
    search(i, j + 1, grid);
}

const numIslands = (grid) => {
    let total = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === '1') {
                search(i, j, grid);
                total++;
            }
        }
    }
    return total;
};

// Alien Dictionary

class Vertex {
    constructor(c) {
        this.id = c;
        this.inEdges = new Set();
        this.outEdges = new Set();
    }
    addInEdge(c) {
        this.inEdges.add(c);
    }

    addOutEdge(c) {
        this.outEdges.add(c);
    }
}

function alienOrder (words) {
    if (words === null || words.length === 0) return "";

    let graph = {};
    let result = "";

    for(let i = 0; i < words.length; i++){
        let word = words[i];
        // build graph
	for(let j = 0; j < words[i].length; j++){
            if (graph[word[j]] === undefined) graph[word[j]] = new Vertex(word[j]);
        }
        // setup in and out edges
        if (i > 0) setNeighbors(words[i-1], words[i], graph);
    }
    // console.log(graph);
    return topologicalSort(graph, result);
}

function setNeighbors(s, t, graph) {
    for(let i = 0; i < Math.min(s.length, t.length); i++){
		v1 = graph[s[i]];
		v2 = graph[t[i]];
                // setup in & out edges
		if(v1.id !== v2.id){
			v1.addOutEdge(v2.id);
			v2.addInEdge(v1.id);
			break;
		}
	}
}

function topologicalSort(graph, result) {
    let queue = [];
    for (let key in graph) {
        if (graph[key].inEdges.size === 0) queue.push(graph[key]);
    }
    while(queue.length !== 0) {
        let curr = queue.shift();
        result += curr.id;
        for(let outEdge of curr.outEdges) {
            graph[outEdge].inEdges.delete(curr.id);
            if (graph[outEdge].inEdges.size === 0) queue.push(graph[outEdge]);
        }
    }
    if(result.length !== Object.keys(graph).length) return "";
    return result;
}

// Topological sort

def topological_sort(vertices)
  order = []
  queue = []
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    current = queue.shift
    order << current
    current.out_edges.dup.each do |edge|
      to_vert = edge.to_vertex
      queue << to_vert if to_vert.in_edges.count <= 1
      edge.destroy!
    end
  end

  order.length == vertices.length ? order : []
end

// delete from BST

function deleteFromBST(t, queries) {
  for (let i = 0; i < queries.length; i++) {
    t = deleteNode(t, queries[i]);
  }
  return t;
}

function deleteNode(t, node) {
  if (t == null) return null;
  if (t.value == node) {
    if (t.left == null && t.right == null) t = null;
    else if (t.left == null) {
      t = t.right;
    } else {
      let x = max(t.left);
      x.left = deleteMax(t.left);
      x.right = t.right;
      return x;
    }
  } else {
    t.left = deleteNode(t.left, node);
    t.right = deleteNode(t.right, node);
  }
  return t;
}

function deleteMax(x) {
  if (x.right == null) return x.left;
  x.right = deleteMax(x.right);
  return x;
}

function max(x) {
  while (x.right != null) x = x.right;
  return x;
} 


