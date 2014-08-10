$ -> # on dom ready
  $("#cy").cytoscape

    ready: ->
      window.cy = this
      
      cy.on "tap", (e) ->
        console.log e
