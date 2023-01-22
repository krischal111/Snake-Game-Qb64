'This game will put its code in local disk E: in order to run
'You gotta enter the code as told in the prompt to activate the game
'You can optionally press ctrl + A for activation without any code
'press ctrl + M to play this game without any code to enter, you have to do this every time you run this game
'You can also press ctrl + E if you do not have local disk E: or you want to save somewhere else This game will prompt to save in other local disk
'or any other readable location.
'you have to press these shortcut keys at the time of loading otherwise may not work




declare function keypress$(time)
declare sub gameover(score, headlocation())
_FullScreen _SquarePixels
Screen 12
$ExeIcon:'e:/other/qb64/qbasic game icon.ico'
_Title "Snake game"



Dim Shared starttime, bk$, auth, mode$, soundon, gmovroff
Dim Shared control$(4)
soundon = -1
Locate 5
Color 6, 15
Cls
'PRINT "         Welcome to snake game"
Print
Print
Print "                ‹ﬂﬂﬂﬂﬂﬂ   €‹     €    ‹ﬂﬂﬂ‹   €    ‹ﬂ  €ﬂﬂﬂﬂﬂ"
Print "                ›         € €    €   €     €  €  ‹ﬂ    €"
Print "                ﬂﬂ€€€‹‹   €  ﬂ‹  €   €‹‹‹‹‹€  €‹ﬂ      €€€€€"
Print "                      ﬁ   €    € €   €     €  € ﬂ‹     €"
Print "                ‹‹‹‹‹‹ﬂ   €     ﬂ€   €     €  €   ﬂ‹   €‹‹‹‹‹"
Print
Print
Print "                   ‹ﬂﬂﬂﬂﬂﬂ     ‹ﬂﬂﬂ‹    €‹     ‹€   €ﬂﬂﬂﬂﬂ"
Print "                   €          €     €   € ﬂ‹ ‹ﬂ €   €"
Print "                   €    ﬂﬂ‹   €‹‹‹‹‹€   €   ﬂ   €   €€€€€"
Print "                   €      €   €     €   €       €   €"
Print "                   ﬂ‹‹‹‹‹‹ﬂ   €     €   €       €   €‹‹‹‹‹"
Print
Print "                               /ƒƒƒƒƒƒƒƒƒ\"
Print "                               › O     O ›"
Print "                               ›    x    ›"
Print "                               ›  \___/  ›"
Print "                               \____  ___/"
Print "                                    › ›"
Print "                                    › ›"
Print "                                 ƒƒ-/ ›"
Print "                                 _____/ "
Print
Print
Print
Print "                                                        By Krischal Khanal."

_Delay 2
x$ = InKey$
'----------------------------------------------------------check authorization--------------------------------------------


Cls
Screen 13
Print "Your game is about to begin"
For i = 1 To 300
    If x$ = "" Then
        x$ = InKey$
    End If
    If i Mod 150 = 1 Then
        Locate 2
        Print "Loading .. "
    ElseIf i Mod 150 = 50 Then
        Locate 2
        Print "Loading ..."
    ElseIf i Mod 150 = 100 Then
        Locate 2
        Print "Loading .  "
    End If
    Line (7, 23)-(308, 32), 4, B
    Line (8, 24)-(7 + i, 31), 14, BF
    _Delay .007
Next i
_Delay .5

Let save_path$ = "E:\"
If Not _DirExists(save_path$) Then
    save_path$ = ".data_snake/"
    If Not _DirExists(save_path$) Then
        MkDir save_path$
    End If
End If



If exist%("path.dat") Then
    Print "New custom path detected"
    Print "Game data will be saved in that location"
    Print "If you want to disable this window, then delete path.dat file on the place where this game exists"
    Print "press esc to cancel save process"
    Sleep 1
    If Not InKey$ = Chr$(27) Then
        Open "path.dat" For Input As #1
        Input #1, path$
        ChDir path$
        Close #1
    Else
        ChDir save_path$
    End If
Else
    ChDir save_path$
End If

'----------------uncomment following line to activate without anything--------------------------
'If Not exist%("authorization.dat") Then GoTo activation

activation_text$ = "Yes, allow to play the game because code is present, code present token=(Some-info-mostly-only-I-know), Krischal"
auth = 0

Select Case x$
    Case Chr$(1)
        Cls
        GoTo activation
    Case Chr$(5)
        Cls
        Input "Please enter the valid location to save your game."; path$
        Open "path.dat" For Output As #1
        Write #1, path$
        Close #1
    Case Chr$(14)
        auth = 1
        GoTo playwithoutcode
End Select

Screen 12



If exist%("authorization.dat") Then
    Open "authorization.dat" For Input As #1
    Input #1, code$
    Close #1
    '-----------------------------originally, my code exposed my Date of birth, and it may be some privacy risk------------------------
    'If code$ = "Yes, allow to play the game because code is present, code present token=(DOB), Krischal" Then
    If code$ = activation_text$ Then
        auth = 1
    Else
        'Print "Please update your code again"
        'Print
        Print "In this new version of this game, I changed the key way activation works."
        Print "So, previously activated version may not work with this. So, you cannot use this game"
        GoTo Joking
    End If
    Close #1
Else
    d$ = Date$
    d$ = Mid$(d$, 7, 4) + "-" + Mid$(d$, 1, 2) + "-" + Mid$(d$, 4, 2)

    Screen 12
    Print "Today's date is "; d$
    If d$ < "2018-07-06" Then
        beginning:
        Input "Enter the code to activate the game"; code$
        If code$ = "0346257O" Then
            activation:

            Open "authorization.dat" For Output As #1
            ' Write #1, "Yes, allow to play the game because code is present, code present token=(DOB), Krischal"
            Write #1, activation_text$
            Close #1
            auth = 1
            Print "Your code is correct."
            Print "Entering the game."
            Sleep 1

        Else
            Print "Sorry you cannot play the game because your code is not correct."
            Print "For correct code, contact Krischal Khanal, the creator of the game."
            Print "Press `R' if you want to reenter the code"
            Sleep 5
            x$ = InKey$
            If UCase$(x$) = "R" Then GoTo beginning
        End If
    Else
        Print "Sorry, the game has expired."
        Joking:
        Print
        Sleep 5
        Print "Ha! Just joking. You may now enter the code. Please enter `0346257O' on the next prompt to activate."
        Print
        Print "Trivia:"
        Print "Originally, when I made this game, being too much concerned about other accessing this game without " + "my permission, I added a time limit to activate it before 2018-07-26, about one month after game creation.";
        Print
        Print
        GoTo beginning
    End If
End If
If auth = 0 Then End


playwithoutcode:

'-------------------------------------------------------------------check authorization block end-------------------------

Call loadcontrols

If exist%("highscore.dat") Then
    Open "highscore.dat" For Input As #1
    Input #1, n$, bestscore
    Close #1
Else
    bestscore = 0
End If

Dim Shared level
level = 9
_Delay .5
Screen 13

Call menu
System


Sub game (level)

    Shared lgth
    Shared gmovroff

    Screen 7
    Dim SNAKE(444, 2)
    Dim snakedirection(400) As Integer
    Dim pts(2, 2)

    pts(1, 1) = 9
    pts(1, 2) = 9

    If lgth = 0 Then
        l = 5
    Else
        l = lgth
    End If

    Color , 3
    Cls

    Line (4, 4)-(172, 172), 5, BF
    Line (7, 7)-(168, 168), 0, BF
    starttime = Timer

    'PRINT CHR$(176) + CHR$(177)
    bk$ = "D"
    Do
        presenttime = Timer
        If oddeven = 1 Then oddeven = oddeven - 2
        oddeven = oddeven + 1
        If Not mode$ = "AI" Then
            k$ = keypress$((2 / (level ^ 1.4)))
        Else
            k$ = AIinput$(SNAKE(), pts(), p2, bk$, l)
        End If

        kprss$ = k$

        k$ = UCase$(k$)
        If k$ = "W" Then
            If Not bk$ = "S" Then
                y = y - 1
                If y < 0 Then y = 19
                bk$ = k$
            Else
                GoTo blankcondition
            End If
        ElseIf k$ = "A" Then
            If Not bk$ = "D" Then
                x = x - 1
                If x < 0 Then x = 19
                bk$ = k$
            Else
                GoTo blankcondition
            End If
        ElseIf k$ = "S" Then
            If Not bk$ = "W" Then
                y = y + 1
                If y >= 20 Then y = 0
                bk$ = k$
            Else
                GoTo blankcondition
            End If
        ElseIf k$ = "D" Then
            If Not bk$ = "A" Then
                x = x + 1
                If x >= 20 Then x = 0
                bk$ = k$
            Else
                GoTo blankcondition
            End If
        ElseIf k$ = "" Or k$ = " " Then
            If k$ = " " Then
                Color , 9
                Locate 11, 23
                Print "Press any key to"
                Locate 12, 23
                Print "continue the game"
                Sleep
                Color , 3
                Locate 11, 23
                Print Space$(17)
                Locate 12, 23
                Print Space$(17)
            End If
            blankcondition:
            k$ = bk$
            Select Case UCase$(k$)
                Case "W"
                    y = y - 1
                    If y < 0 Then y = 19
                    bk$ = k$
                Case "A"
                    x = x - 1
                    If x < 0 Then x = 19
                    bk$ = k$
                Case "S"
                    y = y + 1
                    If y >= 20 Then y = 0
                    bk$ = k$
                Case "D"
                    x = x + 1
                    If x >= 20 Then x = 0
                    bk$ = k$
            End Select
        ElseIf Asc(k$) = 27 Then
            Exit Do
        End If
        Select Case bk$
            Case "W"
                snakedirection(1) = 1
            Case "A"
                snakedirection(1) = 2
            Case "S"
                snakedirection(1) = 3
            Case "D"
                snakedirection(1) = 4
        End Select

        Locate y + 2, x + 2
        For i = 0 To 2
            Locate SNAKE(l + i, 1) + 2, SNAKE(l + i, 2) + 2
            Print " "
        Next i
        Color 14
        For i = l To 2 Step -1
            SNAKE(i, 1) = SNAKE(i - 1, 1)
            SNAKE(i, 2) = SNAKE(i - 1, 2)
            snakedirection(i) = snakedirection(i - 1)

            Locate SNAKE(i, 1) + 2, SNAKE(i, 2) + 2

            If i Mod 3 = 0 Then Print Chr$(8) Else Print Chr$(219)
            Call trimsnake(SNAKE(i, 2), SNAKE(i, 1), snakedirection(i), snakedirection(i + 1), &HFF00)
        Next i

        Locate SNAKE(l - 2, 1) + 2, SNAKE(l - 2, 2) + 2
        Print Chr$(178)
        Call trimsnake(SNAKE(l - 2, 2), SNAKE(l - 2, 1), snakedirection(l - 2), snakedirection(l - 1), &O33333)

        Locate SNAKE(l - 1, 1) + 2, SNAKE(l - 1, 2) + 2
        Print Chr$(177)
        Call trimsnake(SNAKE(l - 1, 2), SNAKE(l - 1, 1), snakedirection(l - 1), snakedirection(l), &HAAAA1)

        Locate SNAKE(l, 1) + 2, SNAKE(l, 2) + 2
        Print Chr$(176)
        Call trimsnake(SNAKE(l, 2), SNAKE(l, 1), snakedirection(l), 0, &O11111)


        SNAKE(1, 1) = y: SNAKE(1, 2) = x
        Locate SNAKE(1, 1) + 2, SNAKE(1, 2) + 2
        Print Chr$(2)

        '    PRINT CHR$(177)
        '-------------------------------------------------- points at random place ------------------



        If y = pts(1, 1) And x = pts(1, 2) Then
            If soundon Then
                Sound 0, 0
                Sound 200, 2
                Sound 0, 0
                Sound 350, 2
            End If
            l = l + 1
            score = score + level
            While 1
                Randomize Timer
                x1 = Int(Rnd * 20)
                y1 = Int(Rnd * 20)
                For j = 1 To l
                    If x1 = SNAKE(j, 1) And y1 = SNAKE(j, 2) Then redo = 1: Exit For Else redo = 0
                Next j
                If redo = 0 Then Exit While
            Wend
            pts(1, 1) = x1
            pts(1, 2) = y1
            If l Mod 5 = 0 Then
                While 1
                    Randomize Timer
                    x1 = Int(Rnd * 20)
                    y1 = Int(Rnd * 20)
                    For j = 1 To l
                        If x1 = SNAKE(j, 1) And y1 = SNAKE(j, 2) Then redo = 1: Exit For Else redo = 0
                    Next j
                    If redo = 0 Then Exit While
                Wend
                pts(2, 1) = x1
                pts(2, 2) = y1
                p2 = 1
                t = 40

                Line (184, 40)-(304, 47), 14, BF
                Color 11
                If soundon Then
                    Sound 0, 0
                    Sound 300, 2
                    Sound 0, 0
                    Sound 180, 2
                End If
            End If
            If soundon Then
                Sound 0, 0
                Sound 600, 4
            End If

        End If
        If y = pts(2, 1) And x = pts(2, 2) And p2 = 1 Then
            If soundon Then
                Sound 0, 0
                Sound 190, 2.5
                Sound 0, 0
                Sound 320, 2.2
                Sound 0, 0
                Sound 570, 5
            End If

            Locate 6, 23
            Print Space$(16)

            l = l - Int(t * 3 / 40)
            score = score + Int((t / 2) ^ 1.5 / 10 * 1.5 ^ (level))
            p2 = 0
        End If


        t = t - 1



        Locate pts(1, 1) + 2, pts(1, 2) + 2
        If oddeven = 0 Then
            Print Chr$(197)
        Else
            Print Chr$(43)
        End If
        If p2 = 1 Then
            Locate pts(2, 1) + 2, pts(2, 2) + 2
            If oddeven = 0 Then
                Print "o"
            Else
                Print "O"
            End If



            Line (184 + Int(t * 3), 40)-(304, 47), 3, BF


            If t <= 0 Then
                p2 = 0
                If soundon Then
                    Sound 0, 0
                    Sound 350, 2
                    Sound 0, 0
                    Sound 250, 3
                End If
                Locate pts(2, 1) + 2, pts(2, 2) + 2
                Print " "
            End If
        End If

        Color 11
        Locate 2, 23
        Print "Level       "; level
        Locate 3, 23
        Print "Score "; score
        Locate 4, 23
        Print "Snake length"; l
        If p2 Then
            'LINE (8, 184)-(12, 334), 4, BF
            'LINE (8, (20 - t) / 20 * 150 + 184)-(12, 334), 3, BF
        End If

        Call controls(snakedirection(1), kprss$)



        '----------------------------------------- check game over  ------------------------------------
        If gmovroff = 0 Then
            For j = 2 To l
                If y = SNAKE(j, 1) And x = SNAKE(j, 2) Then Call gameover(score, y, x): g = 1: Exit Do Else g = 0
            Next j
        End If

        '-----------------------------------------------------------print direction---------------------

    Loop


    Cls
    Print "Bye"
End Sub

'---------------------------------------------------menu------------------------------------------------------
Sub menu
    menu1st:
    Screen 13
    Color 15, 3
    menu1:
    Cls

    Color 15
    If crx = 1 Then Color 2
    Print "1. Enter the game"

    Color 15
    If crx = 2 Then Color 2
    Print "2. Change the level"

    Color 15
    If crx = 3 Then Color 2
    Print "3. Check best scores"


    Color 15
    If crx = 4 Then Color 2
    Print "4. Settigs"

    Color 15
    If crx = 5 Then Color 2
    Print "5. Help"


    Color 15
    If crx = 6 Then Color 2
    Print "6. Exit (Esc key)"

    Do
        x$ = InKey$
        If _MouseInput Then
            my = _MouseY
            crx = Int(my / 8) + 1
            If _MouseButton(1) Then
                GoTo act1
            End If

            GoTo menu1
        End If

        checkagain:
        Select Case x$
            Case Chr$(0) + "P"
                crx = crx + 1
                If crx > 6 Then crx = 1
                GoTo menu1:
            Case Chr$(0) + "H"
                crx = crx - 1
                If crx < 1 Then crx = 6
                GoTo menu1:
            Case Chr$(27)
                Exit Do
            Case "1", "2", "3", "4", "5", "6"
                If crx = Val(x$) Then x$ = Chr$(13): GoTo checkagain
                crx = Val(x$)
                GoTo menu1:
            Case Chr$(13)
                act1:
                x$ = ""
                If crx = 6 Then Exit Do Else Call menuhandler(crx)
                GoTo menu1st:
        End Select
    Loop

    Cls
    Color 4
    Print "     Do you really want to exit?"
    Print "(Enter) for `YES' and (Esc) key for `NO'."
    Do
        x$ = InKey$
        If _MouseInput Then
            my = Int(_MouseY / 8) + 1
            mx = Int(_MouseX / 8) + 1
            If mx >= 13 And mx <= 17 And my = 2 Then
                Locate 2, 13
                Color 2
                Print "`YES'"

            Else
                Locate 2, 13
                Color 4
                Print "`YES'"
            End If

            If mx >= 37 And mx <= 40 And my = 2 Then
                Locate 2, 37
                Color 2
                Print "`NO'"

            Else
                Locate 2, 37
                Color 4
                Print "`NO'"
            End If


            If _MouseButton(1) Then
                If mx >= 13 And mx <= 17 And my = 2 Then
                    x$ = Chr$(13)
                End If

                If mx >= 37 And mx <= 40 And my = 2 Then
                    x$ = Chr$(27)
                End If

            End If

        End If

    Loop While x$ = ""

    If x$ = Chr$(13) Then GoTo menu9
    GoTo menu1
    menu9:
    Locate 2, 13
    Color 2
    Print "`YES'"
    _Delay .25

End Sub

'------------------------------------------------menu handler---------------------------------------------------
Sub menuhandler (crx)
    Select Case crx
        Case 1
            Call game(level)
        Case 2
            crx1 = level
            menu2:
            Cls
            Color 15
            If crx1 = 1 Then Color 2
            Print "Level 1"

            Color 15
            If crx1 = 2 Then Color 2
            Print "Level 2"

            Color 15
            If crx1 = 3 Then Color 2
            Print "Level 3"

            Color 15
            If crx1 = 4 Then Color 2
            Print "Level 4"

            Color 15
            If crx1 = 5 Then Color 2
            Print "Level 5"

            Color 15
            If crx1 = 6 Then Color 2
            Print "Level 6"

            Color 15
            If crx1 = 7 Then Color 2
            Print "Level 7"

            Color 15
            If crx1 = 8 Then Color 2
            Print "Level 8"

            Color 15
            If crx1 = 9 Then Color 2
            Print "Level 9"

            Color 15
            If crx1 = 10 Then Color 2
            Print "Level 10"
            Do
                x$ = InKey$

                If _MouseInput Then
                    my = _MouseY
                    crx1 = Int(my / 8) + 1
                    If _MouseButton(1) Then
                        GoTo act2
                    End If

                    GoTo menu2
                End If

                checkagain1:
                Select Case x$
                    Case Chr$(0) + "P"
                        crx1 = crx1 + 1
                        If crx1 > 10 Then crx1 = 1
                        GoTo menu2:
                    Case Chr$(0) + "H"
                        crx1 = crx1 - 1
                        If crx1 < 1 Then crx1 = 10
                        GoTo menu2:

                    Case "1", "2", "3", "4", "5", "6", "7", "8", "8", "9", "0"
                        If crx = Val(x$) Or crx = Val(x$) + 10 Then x$ = Chr$(13): GoTo checkagain1
                        crx = Val(x$)
                        If crx = 0 Then crx = 10
                        GoTo menu2:

                    Case Chr$(12)
                        Cls
                        Input "Mannually input the level"; level
                        GoTo menu2:
                    Case Chr$(13), Chr$(27)
                        act2:
                        If x$ = Chr$(13) Then level = crx1
                        Exit Do
                End Select
            Loop
        Case 3
            Screen 12
            Shared bestscore
            If exist%("highscore.dat") Then
                Open "highscore.dat" For Input As #1
                Input #1, n$, bestscore
                Close #1
            End If
            Cls
            Print "Name", , "Score"
            Print n$, bestscore
            Print
            Print
            Print "Press del key to reset best scores."
            Sleep
            x$ = InKey$
            If x$ = Chr$(0) + Chr$(83) Then
                Cls
                Print "Do you really want to delete your best scores?(Enter or Escape)"
                Sleep
                x$ = InKey$
                If x$ = Chr$(13) Then
                    If exist%("highscore.dat") Then Kill "highscore.dat"
                    bestscore = 0
                    Print "Successfully deleted"
                    Print "Press any key to return to menu"
                    Sleep
                    x$ = InKey$
                End If
                Cls
            End If
            Screen 13
        Case 4
            menu3:
            Cls
            Color 15
            If crx1 = 1 Then Color 2
            Print "1. Redefine controls"
            Color 15
            If crx1 = 2 Then Color 2
            Print "2. Control mode"
            Color 15
            If crx1 = 3 Then Color 2
            Print "3. Sound"

            Do
                x$ = InKey$
                If _MouseInput Then
                    my = _MouseY
                    crx1 = Int(my / 8) + 1
                    If _MouseButton(1) Then
                        GoTo act3
                    End If

                    GoTo menu3
                End If


                Select Case x$
                    Case Chr$(0) + "P"
                        crx1 = crx1 + 1
                        If crx1 > 3 Then crx1 = 1
                        GoTo menu3:
                    Case Chr$(0) + "H"
                        crx1 = crx1 - 1
                        If crx1 < 1 Then crx1 = 3
                        GoTo menu3:
                    Case Chr$(13)
                        act3:
                        Select Case crx1
                            Case 1
                                Cls
                                menu31:
                                Cls
                                Color 15
                                If crx2 = 1 Then Color 2
                                Print "Up           "; "Current key=(" + control$(1) + ")"
                                Color 15
                                If crx2 = 2 Then Color 2
                                Print "Down         "; "Current key=(" + control$(2) + ")"
                                Color 15
                                If crx2 = 3 Then Color 2
                                Print "Left         "; "Current key=(" + control$(3) + ")"
                                Color 15
                                If crx2 = 4 Then Color 2
                                Print "Right        "; "Current key=(" + control$(4) + ")"

                                While 1
                                    x$ = InKey$
                                    If _MouseInput Then
                                        my = _MouseY
                                        crx2 = Int(my / 8) + 1
                                        If _MouseButton(1) Then
                                            GoTo act31
                                        End If

                                        GoTo menu31
                                    End If


                                    Select Case x$
                                        Case Chr$(0) + "P"
                                            crx2 = crx2 + 1
                                            If crx2 > 4 Then crx2 = 1
                                            GoTo menu31:
                                        Case Chr$(0) + "H"
                                            crx2 = crx2 - 1
                                            If crx2 < 1 Then crx2 = 4
                                            GoTo menu31:
                                        Case "1", "2", "3", "4"
                                            crx2 = Val(x$)
                                            GoTo menu31
                                        Case Chr$(13)
                                            act31:
                                            Cls
                                            Print "Press a key to assign the control"
                                            Sleep
                                            control$(crx2) = InKey$
                                            Open "controls.dat" For Output As #1
                                            Write #1, control$(1), control$(2), control$(3), control$(4)
                                            Close #1
                                            Print "Assignation successful"
                                            Sleep
                                            Cls
                                            GoTo menu3
                                        Case Chr$(27)
                                            GoTo menu3
                                    End Select
                                Wend
                            Case 2
                                menu4:
                                Cls
                                Color 15
                                If crx3 = 1 Then Color 2
                                Print "1. Human"
                                Color 15
                                If crx3 = 2 Then Color 2
                                Print "2. Artificial Intelligence"

                                Do
                                    x$ = InKey$

                                    If _MouseInput Then
                                        my = _MouseY
                                        crx3 = Int(my / 8) + 1
                                        If _MouseButton(1) Then
                                            GoTo act4
                                        End If

                                        GoTo menu4
                                    End If

                                    Select Case x$
                                        Case Chr$(0) + "P"
                                            crx3 = crx3 + 1
                                            If crx3 > 2 Then crx3 = 1
                                            GoTo menu4
                                        Case Chr$(0) + "H"
                                            crx3 = crx3 - 1
                                            If crx3 < 1 Then crx3 = 2
                                            GoTo menu4
                                        Case Chr$(13)
                                            act4:
                                            If crx3 = 2 Then mode$ = "AI" Else mode$ = ""
                                            GoTo outdo
                                        Case Chr$(27)
                                            GoTo outdo
                                        Case Chr$(12)
                                            Cls
                                            Shared lgth
                                            Input "Mannually input the initial length of the snake"; lgth
                                            GoTo menu4
                                        Case Chr$(11)
                                            Shared gmovroff
                                            Screen 12
                                            Cls
                                            Input "Enter the code of disabling gameover"; n$
                                            If UCase$(n$) = "IAMGOD" Then gmovroff = 1: Screen 13: GoTo menu4 Else Screen 13: Print "Wrong password"; gmovroff = 0:: Sleep
                                        Case ""
                                        Case Else: GoTo menu4
                                    End Select

                                Loop
                                outdo:
                            Case 3

                                menu5:

                                Cls
                                Color 15
                                If crx4 = 1 Then Color 2
                                Print "1. On"
                                Color 15
                                If crx4 = 2 Then Color 2
                                Print "2. Off"

                                Do
                                    x$ = InKey$
                                    If _MouseInput Then
                                        my = _MouseY
                                        crx4 = Int(my / 8) + 1
                                        If _MouseButton(1) Then
                                            GoTo act5
                                        End If

                                        GoTo menu5
                                    End If

                                    Select Case x$
                                        Case Chr$(0) + "P"
                                            crx4 = crx4 + 1
                                            If crx4 > 2 Then crx4 = 1
                                            GoTo menu5
                                        Case Chr$(0) + "H"
                                            crx4 = crx4 - 1
                                            If crx4 < 1 Then crx4 = 2
                                            GoTo menu5
                                        Case Chr$(13)
                                            act5:
                                            If crx4 = 2 Then soundon = 0 Else soundon = -1
                                            GoTo outdo2
                                        Case Chr$(27)
                                            GoTo outdo2
                                        Case ""
                                        Case Else: GoTo menu5
                                    End Select
                                Loop
                                outdo2:
                        End Select




                        Exit Do
                    Case Chr$(27)
                        Exit Do
                End Select


            Loop


        Case 5
            Screen 12
            Print "This is the snake game."
            Print "Use navigation keys to control through the menu."
            Print "Use either navigation keys or "; control$(1) + control$(3) + control$(2) + control$(4); " keys to control the snake in game."
            Print "You can also add your own custom controls through menu"
            Print "Eating `+' points will increase snake's length by one and your score by the     level you are"
            Print "Eating `O' points will decrease snake's length upto maximum 2 and score by how  fast you approach it and your level."
            Print "`O' points will appear whenever snake's length becomes the multiple of five."
            Print "Press `Spacebar' to pause the game."
            Print "Game is over if the snake eats itself."
            Print "You will come back from another end if you enter the another end."
            Print
            Print
            Print
            Print "This game is made by Krischal Khanal."
            Sleep
            x$ = InKey$
            Screen 13

    End Select


End Sub


Function keypress$ (time)
    pt = Timer
    Do
        If kp$ = "" Then
            kp$ = InKey$
            kp$ = UCase$(kp$)
        End If
        Select Case kp$
            Case Chr$(0) + "H", UCase$(control$(1))
                kp$ = "W"
            Case Chr$(0) + "K", UCase$(control$(3))
                kp$ = "A"
            Case Chr$(0) + "P", UCase$(control$(2))
                kp$ = "S"
            Case Chr$(0) + "M", UCase$(control$(4))
                kp$ = "D"
        End Select
        Select Case UCase$(kp$)
            Case "W", "A", "S", "D"
                k$ = UCase$(kp$)
                If k$ = "W" And Not bk$ = "S" Then
                ElseIf k$ = "A" And Not bk$ = "D" Then
                ElseIf k$ = "S" And Not bk$ = "W" Then
                ElseIf k$ = "D" And Not bk$ = "A" Then
                Else
                    kp$ = ""
                End If
            Case Chr$(27), " "
            Case Else
                kp$ = ""
        End Select
        nt = Timer
        d = nt - pt
        If d < 0 Then pt = pt - 86400
        If d > time Then Exit Do

    Loop
    While 0: Wend
    keypress$ = UCase$(kp$)

End Function

Sub gameover (score, x, y)
    Shared bestscore
    If soundon Then
        Sound 0, 0
        Sound 200, 3
        Sound 0, 0
        Sound 220, 3
        Sound 0, 0
        Sound 280, 5
        Sound 0, 0
        Sound 225, 3
        Sound 0, 0
        Sound 250, 3
        Sound 0, 0
        Sound 300, 5
        Sound 0, 0
        Sound 220, 3
        Sound 0, 0
        Sound 250, 3
        Sound 0, 0
        Sound 300, 3
        Sound 0, 0
        Sound 250, 3
        Sound 0, 0
        Sound 200, 7
        Sound 0, 0
    End If
    For i = 1 To 7
        Color 14
        Locate x + 2, y + 2
        _Delay .20
        Print Chr$(2)
        _Delay .15
        Color 4
        Locate x + 2, y + 2
        Print Chr$(219)
    Next i
    Cls
    Print "               Game over"
    bk$ = "D"

    If score >= bestscore Then
        bestscore = score
        Print "New high score"; score
        If mode$ = "" Then
            Input "Enter your name"; n$
            Print "Thank you"
        ElseIf mode$ = "AI" Then
            Print "Enter your name ";
            _Delay .5: Print "A";: _Delay .1: Print "r";: _Delay .1: Print "t";: _Delay .1: Print "i";: _Delay .1: Print "f";: _Delay .1:
            Print "i";: _Delay .1: Print "c";: _Delay .1: Print "i";: _Delay .1: Print "a";: _Delay .1: Print "l";: _Delay .1: Print " ";: _Delay .1
            Print "I";: _Delay .1: Print "n";: _Delay .1: Print "t";: _Delay .1: Print "e";: _Delay .1: Print "l";: _Delay .1: Print "l";: _Delay .1:
            Print "i";: _Delay .1: Print "g";: _Delay .1: Print "e";: _Delay .1: Print "n";: _Delay .1: Print "c";: _Delay .1: Print "e"
            Sleep 1
            n$ = "Artificial Intelligence"
            Print "Thank you"
        End If







        Open "highscore.dat" For Output As #1
        If Len(n$) < 14 Then n$ = n$ + Space$(14)
        Write #1, n$, score
        Close #1
    Else
        Print "Your score was"; score
    End If

    Sleep 3
    x$ = InKey$
End Sub


Function exist% (file$)
    f = FreeFile
    Open file$ For Append As #f
    If LOF(f) Then exist% = -1: Close #f Else exist% = 0: Close #f: Kill file$
End Function


Sub loadcontrols
    If exist%("controls.dat") Then
        Open "controls.dat" For Input As #1
        Input #1, control$(1), control$(2), control$(3), control$(4)
        Close #1
    Else
        control$(1) = "W"
        control$(2) = "S"
        control$(3) = "A"
        control$(4) = "D"
    End If
End Sub



Sub trimsnake (x, y, dplus, dminus, style)
    clr = 14

    Line (x * 8 + 8, y * 8 + 8)-(x * 8 + 15, y * 8 + 15), 0, B
    Select Case dplus
        Case 1
            Line (x * 8 + 9, y * 8 + 8)-(x * 8 + 14, y * 8 + 8), clr, , style
        Case 2
            Line (x * 8 + 8, y * 8 + 9)-(x * 8 + 8, y * 8 + 14), clr, , style
        Case 3
            Line (x * 8 + 9, y * 8 + 15)-(x * 8 + 14, y * 8 + 15), clr, , style
        Case 4
            Line (x * 8 + 15, y * 8 + 9)-(x * 8 + 15, y * 8 + 14), clr, , style
    End Select

    Select Case dminus
        Case 3
            Line (x * 8 + 9, y * 8 + 8)-(x * 8 + 14, y * 8 + 8), clr, , style
        Case 4
            Line (x * 8 + 8, y * 8 + 9)-(x * 8 + 8, y * 8 + 14), clr, , style
        Case 1
            Line (x * 8 + 9, y * 8 + 15)-(x * 8 + 14, y * 8 + 15), clr, , style
        Case 2
            Line (x * 8 + 15, y * 8 + 9)-(x * 8 + 15, y * 8 + 14), clr, , style
    End Select

End Sub



Sub controls (direc, kprss$)

    Locate 9, 25
    Print Chr$(24)
    Locate 10, 24
    Print Chr$(27)
    Locate 10, 25
    Print Chr$(25)
    Locate 10, 26
    Print Chr$(26)
    Color 2

    Line (183 + 8, 63 + 0)-(183 + 16, 63 + 8), 1, B
    Line (183 + 0, 63 + 8)-(183 + 8, 63 + 16), 1, B
    Line (183 + 8, 63 + 8)-(183 + 16, 63 + 16), 1, B
    Line (183 + 16, 63 + 8)-(183 + 24, 63 + 16), 1, B
    Select Case direc
        Case 1
            dir$ = "Up"
        Case 2
            dir$ = "Left"
        Case 3
            dir$ = "Down"
        Case 4
            dir$ = "Right"
    End Select


    Select Case kprss$
        Case "W"
            Locate 9, 25
            Print Chr$(24)

        Case "A"
            Locate 10, 24
            Print Chr$(27)

        Case "S"
            Locate 10, 25
            Print Chr$(25)

        Case "D"
            Locate 10, 26
            Print Chr$(26)

    End Select

    Color 11
    Locate 7, 23
    Print "     "
    Locate 7, 23
    Print dir$
    Line (183 + 8, 63 + 0)-(183 + 16, 63 + 8), 1, B
    Line (183 + 0, 63 + 8)-(183 + 8, 63 + 16), 1, B
    Line (183 + 8, 63 + 8)-(183 + 16, 63 + 16), 1, B
    Line (183 + 16, 63 + 8)-(183 + 24, 63 + 16), 1, B
End Sub

Function AIinput$ (snake(), pts(), p2, bk$, l)
    Shared x11%
    pg = 0


    reinput:
    If p2 Then
        If rein Xor Abs(snake(1, 1) - pts(2, 1)) >= Abs(snake(1, 2) - pts(2, 2)) Then
            d = (snake(1, 1) - pts(2, 1))
            If (d <= 10 And d > 0) Or (d <= -10) Then
                inp$ = "W"
            Else
                inp$ = "S"
            End If
        Else
            d = (snake(1, 2) - pts(2, 2))
            If (d <= 10 And d > 0) Or (d <= -10) Then
                inp$ = "A"
            Else
                inp$ = "D"
            End If
        End If
    Else
        If rein Xor Abs(snake(1, 1) - pts(1, 1)) >= Abs(snake(1, 2) - pts(1, 2)) Then
            d = (snake(1, 1) - pts(1, 1))
            If (d <= 10 And d > 0) Or (d <= -10) Then
                inp$ = "W"
            Else
                inp$ = "S"
            End If
        Else
            d = (snake(1, 2) - pts(1, 2))
            If (d <= 10 And d > 0) Or (d <= -10) Then
                inp$ = "A"
            Else
                inp$ = "D"
            End If
        End If
    End If


    If level < 50 And level > 0 Then
        _Delay (2 / (level ^ 1.4))
    End If

    If x11% = 400 Then x11 = 0


    If safemode = 1 Then
        If x11% Mod 20 = 0 Then inp$ = "S" Else If x11% Mod 20 = 1 Then inp$ = "D"
    End If
    x11% = x11% + 1






    shortdistance = 0

    If shortdistance Then
        If (inp$ = "W" And bk$ = "S") Or (inp$ = "A" And bk$ = "D") Or (inp$ = "S" And bk$ = "W") Or (inp$ = "D" And bk$ = "A") Then
            rein = 1
            GoTo reinput
        Else
            rein = 0
        End If
    End If


    key$ = InKey$



    If key$ = Chr$(27) Or key$ = " " Then AIinput$ = key$: GoTo fxend

    k$ = UCase$(inp$)
    AIinput$ = k$

    fxend:

End Function
