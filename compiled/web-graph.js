// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    return $("#cy").cytoscape({
      ready: function() {
        window.cy = this;
        return cy.on("tap", function(e) {
          return console.log(e);
        });
      }
    });
  });

}).call(this);
