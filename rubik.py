
# Color face mappings
# Upper -> White
# Left -> Orange
# Front -> Green
# Right -> Red
# Down -> Yellow
# Back -> Blue


input_moves = "D2 B R2 L2 B D2 F' U' B2 R' L F2 U' F' U B2 U2 F U2 B2 L' R2 B' L2 F"

for m in input_moves.split():

    if len(m) != 1 and len(m) != 2:
        print('Length criterion failed: Unable to decode the move %s length = %d' % (m, len(m)))
        exit(-3)


    if m[0] == 'U':
        _m = 'W'
    elif m[0] == 'L':
        _m = 'O'
    elif m[0] == 'F':
        _m = 'G'
    elif m[0] == 'R':
        _m = 'R'
    elif m[0] == 'D':
        _m = 'Y'
    elif m[0] == 'B':
        _m = 'B'
    else:
        print('Unable to decode the move %s @1' % m)
        exit(-1)

    if len(m) == 2:
        if m[1] == '2':
            _m = _m + ' ' + _m
        elif m[1] == '\'':
            _m = _m + ' ' + _m + ' ' + _m
        else:
            print('Unable to decode the move %s @2' % m)
            exit(-2)


    print(_m)