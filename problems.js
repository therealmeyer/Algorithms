// Validate Binary Search Tree

const isValidBST = function(root, prev = null, side = null) {
    if (!root) return true;
    if (side === "left" && root.val > prev.val) return false;
    if (side === "right" && root.val <= prev.val) return false;
    return isValidBST(root.left, root, "left") && isValidBST(root.right, root, "right")
};
