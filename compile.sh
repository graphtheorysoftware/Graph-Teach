#!/bin/sh

coffee -o compiled --watch --compile  web-graph.coffee &
sass --watch web-graph.sass:compiled/web-graph.css &
sass --watch styles.sass:compiled/styles.css &

