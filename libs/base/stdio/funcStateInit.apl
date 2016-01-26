 funcStateInit forceb;fns

⍝ Initilises information about fix time of all functions.
⍝ forceb  1=init always, 0=only if it is not done

 :If forceb∨0=⎕NC'funcStateDATA'
    fns←(↓[2]⎕NL 3 4)~¨' '
    funcStateDATA←(xCol fns)(0 1↓0 ¯1↓↑2 ⎕AT¨fns)
 :EndIf