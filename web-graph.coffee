$ -> # on dom ready
  graphStyles = ''
  $.ajax
     async: false   #we want the styles to be loaded on cy init
     type: 'GET'
     url: 'compiled/web-graph.css'
     success: (data) -> graphStyles = data


  # the default values of each option are outlined below:
  edgeHandlesDefaults =
    preview: true # whether to show added edges preview before releasing selection
    handleSize: 20 # the size of the edge handle put on nodes
    handleColor: "#ff0000" # the colour of the handle and the line drawn from it
    handleLineType: "ghost" # can be 'ghost' for real edge, 'straight' for a straight line, or 'draw' for a draw-as-you-go line
    handleLineWidth: 2 # width of handle line in pixels
    handleNodes: "node" # selector/filter function for whether edges can be made from a given node
    hoverDelay: 150 # time spend over a target node before it is considered a target selection
    cxt: true # whether cxt events trigger edgehandles (useful on touch)
    enabled: true # whether to start the plugin in the enabled state
    toggleOffOnLeave: false # whether an edge is cancelled by leaving a node (true), or whether you need to go over again to cancel (false; allows multiple edges in one pass)


  $("#cy").cytoscape
    style: graphStyles
    ready: ->
      window.cy = this
      
      cy.on "tap", (e) ->
        #add a vertex on click on graph
        if e.cyTarget == cy 
          cy.add
            group: "nodes"
            position: e.cyPosition


      # fired when edgehandles interaction is stopped (either complete with added edges or incomplete)
      cy.edgehandles( edgeHandlesDefaults );

  $('#layout-arbor').click -> cy.layout( name: 'arbor' )
  $('#save-json').click ->    
    $(this).attr 'download', (( ($ '#save-file-name').val() || 'graph') + '.json')
    $(this).attr 'href', "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(cy.elements().jsons()))

  $('#load-json').change (evt) ->
    file = evt.target.files[0] 
    #return unless f.type.match('json')
    reader = new FileReader()
    reader.onload = (event) -> 
      console.log(JSON.parse(event.target.result)['elements'])
      #cy.load(JSON.parse(event.target.result)['elements'])
      cy.add(JSON.parse(event.target.result))
    reader.readAsText file

