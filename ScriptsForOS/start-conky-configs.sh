#!/bin/bash
# Start all Conky instances
conky -c ~/.config/conky/screen1-left.conf &
conky -c ~/.config/conky/screen1-right.conf &
conky -c ~/.config/conky/screen2-left.conf &
conky -c ~/.config/conky/screen2-right.conf &
conky -c ~/.config/conky/todoList1.conf &
conky -c ~/.config/conky/todoList2.conf &
