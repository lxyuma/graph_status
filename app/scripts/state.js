!(function(){
  var State = function(node){
    this.node = node;
  };

  State.prototype.setNeighbors = function(neighbors){
    this.neighbors = neighbors;
  };

  State.read = function(nodes, edges){
    var stateList = [];
    for(var i=0; i < nodes.length; i++){
      var node = nodes[i];
      stateList.push(new State(node));
    }
    return stateList;
  };


})();
