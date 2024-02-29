DiagrammeR::grViz("
digraph Polina_diagram {
  
  # graph statement
  graph [layout = dot,
         rankdir = TB,   # layout top-to-bottom
         fontsize = 12]
  node [shape = circle,
       fixedsize = true
       width = 2.0]
  
  subgraph cluster2 {
  node [fillcolor = Bisque, shape = egg, fontname = Helvetica, fontcolor = darkslategray, shape = rectangle, fixedsize = true, width = 4.0, color = darkslategray, linewidth = 2.0]
  A66 [label = 'Landsat 9 OL/TIRS image \nFebruary 2023 \nLC92050502023022LGN01', shape = rectangle, fontsize = 22, height = 1.5]
  A55 [label = 'Landsat 9 OL/TIRS image \nFebruary 2022 \nLC92050502022051LGN01', shape = rectangle, fontsize = 22, height = 1.5]
  A44 [label = 'Landsat 8 OL/TIRS image \nFebruary 2021 \nLC82050502021056LGN00', shape = rectangle, fontsize = 22, height = 1.5]
  A33 [label = 'Landsat 8 OL/TIRS image \nFebruary 2020 \nLC82050502020038LGN00', shape = rectangle, fontsize = 22, height = 1.5]
  A22 [label = 'Landsat 8 OL/TIRS image \nFebruary 2018 \nLC82050502018048LGN00', shape = rectangle, fontsize = 22, height = 1.5]
  A11 [label = 'Landsat 8 OL/TIRS image \nFebruary 2015 \nLC82050502015056LGN01', shape = rectangle, fontsize = 22, height = 1.5]
  }
  
  A11 -> A22 [fontcolor = red, color = red, style = dashed]
  A33 -> A44 [fontcolor = red, color = red, style = dashed]
  A55 -> A66 [fontcolor = red, color = red, style = dashed]
  
  
  E [label = 'Data import \npreprocessing \nGDAL', fontcolor = darkgreen, shape = egg, fontsize = 24, height = 2.0, width = 2.3 ]
  A44 -> E [fontcolor = darkgreen,color = darkgreen, style = dashed]
  
  F [label = 'Data processing \nGRASS GIS', fontcolor = black, height = 1.5, width = 2.5, shape = tab, fontsize = 24]
  subgraph cluster6 {
  node [fillcolor = Bisque, shape = egg, fontname = Helvetica, fontcolor = darkslategray, shape = rectangle, fixedsize = true, width = 2.5, color = darkslategray]
  F6 [label = '6. Data import \nd.out.file module', fontcolor = black, shape = rectangle, width = 3.5, height = 1.3, fontsize = 22]
  F5 [label = '5. Visualization \nd.rast, d.legend \nr.colors', fontcolor = black, shape = rectangle, width = 3.5, height = 1.3, fontsize = 22]
  F4 [label = '4. Accuracy \nassessment', fontcolor = black, shape = rectangle, width = 2.5, height = 1.3, fontsize = 22]
  F3 [label = '3. Classification\n k-means \ni.maxlik module', fontcolor = black, shape = rectangle, width = 2.5, height = 1.3, fontsize = 22]
  F2 [label = '2. Clustering \ni.cluster module', fontcolor = black, shape = rectangle, width = 2.5, height = 1.3, fontsize = 22]
  F1 [label = '1. Grouping \ni.group module', fontcolor = black, shape = rectangle, width = 2.5, height = 1.3, fontsize = 22]
  }
  
  F1 -> F2 [fontcolor = red, color = red, style = dashed]
  F3 -> F4 [fontcolor = red, color = red, style = dashed]
  F5 -> F6 [fontcolor = red, color = red, style = dashed]
  E -> F [fontcolor = red, color = red, fontsize = 20, style = twodash]
  F -> {F3} [fontcolor = red, color = red, style = dashed]
}
")
