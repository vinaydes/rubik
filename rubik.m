global R = 1;
global G = 2;
global O = 3;
global B = 4;
global W = 5;
global Y = 6;
global Z = 7;

global rotate_right = eye(40, 40);
global rotate_left = eye(40, 40);

function print_state(s)
    global R
    global G
    global O
    global B
    global W
    global Y
    global Z
    for index = 1:40
        switch s(index)
            case R
                printf("\033[41m   \033[0m");
            case G
                printf("\033[42m   \033[0m");
            case O
                printf("\033[48;5;208m\033[38;5;16m   \033[0m");
            case B
                printf("\033[44m   \033[0m");
            case W
                printf("\033[47m   \033[0m");
            case Y
                printf("\033[43m   \033[0m");
            case Z
                printf(" - ");
            otherwise
                printf(" XXXXXXXXXXX ");
        end
        if(mod(index, 8) == 0)
            printf("\n");
        end
    end
end


function prepare_rotate_right()
    global rotate_right;
    % if i -> k, make (i, i) = 0 and (i, k) = 1
    % 12, 20, 28, 36, 38, 39, 32, 24, 16, 7, 6, 4
    % 12 -> 36
    rotate_right(12, 12) = 0; rotate_right(12, 36) = 1;
    % 20 -> 38
    rotate_right(20, 20) = 0; rotate_right(20, 38) = 1;
    % 28 -> 39
    rotate_right(28, 28) = 0; rotate_right(28, 39) = 1;

    % 36 -> 32
    rotate_right(36, 36) = 0; rotate_right(36, 32) = 1;
    % 38 -> 24
    rotate_right(38, 38) = 0; rotate_right(38, 24) = 1;
    % 39 -> 16
    rotate_right(39, 39) = 0; rotate_right(39, 16) = 1;

    % 32 -> 7
    rotate_right(32, 32) = 0; rotate_right(32, 7) = 1;
    % 24 -> 6
    rotate_right(24, 24) = 0; rotate_right(24, 6) = 1;
    % 16 -> 4
    rotate_right(16, 16) = 0; rotate_right(16, 4) = 1;

    % 7 -> 12
    rotate_right(7, 7) = 0; rotate_right(7, 12) = 1;
    % 6 -> 20
    rotate_right(6, 6) = 0; rotate_right(6, 20) = 1;
    % 4 -> 28
    rotate_right(4, 4) = 0; rotate_right(4, 28) = 1;
    % ----------------------------
    % 13, 21, 29, 30, 31, 23, 15, 14
    % 13 -> 29
    rotate_right(13, 13) = 0; rotate_right(13, 29) = 1;
    % 21 -> 30
    rotate_right(21, 21) = 0; rotate_right(21, 30) = 1;
    % 29 -> 31
    rotate_right(29, 29) = 0; rotate_right(29, 31) = 1;
    % 30 -> 23
    rotate_right(30, 30) = 0; rotate_right(30, 23) = 1;
    % 31 -> 15
    rotate_right(31, 31) = 0; rotate_right(31, 15) = 1;
    % 23 -> 14
    rotate_right(23, 23) = 0; rotate_right(23, 14) = 1;
    % 15 -> 13
    rotate_right(15, 15) = 0; rotate_right(15, 13) = 1;
    % 14 -> 21
    rotate_right(14, 14) = 0; rotate_right(14, 21) = 1;

end

function prepare_rotate_left()
    global rotate_left;
    % 9, 17, 25, 34, 35, 36, 29, 21, 13, 4, 3, 2
    % 9 -> 34
    rotate_left(9, 9) = 0; rotate_left(9, 34) = 1;
    % 17 -> 35
    rotate_left(17, 17) = 0; rotate_left(17, 35) = 1;
    % 25 -> 36
    rotate_left(25, 25) = 0; rotate_left(25, 36) = 1;

    % 34 -> 29
    rotate_left(34, 34) = 0; rotate_left(34, 29) = 1;
    % 35 -> 21
    rotate_left(35, 35) = 0; rotate_left(35, 21) = 1;
    % 36 -> 13
    rotate_left(36, 36) = 0; rotate_left(36, 13) = 1;

    % 29 -> 4
    rotate_left(29, 29) = 0; rotate_left(29, 4) = 1;
    % 21 -> 3
    rotate_left(21, 21) = 0; rotate_left(21, 3) = 1;
    % 13 -> 2
    rotate_left(13, 13) = 0; rotate_left(13, 2) = 1;

    % 4 -> 9
    rotate_left(4, 4) = 0; rotate_left(4, 9) = 1;
    % 3 -> 17
    rotate_left(3, 3) = 0; rotate_left(3, 17) = 1;
    % 2 -> 25
    rotate_left(2, 2) = 0; rotate_left(2, 25) = 1;
    % ----------------------------
    % 10, 18, 26, 27, 28, 20, 12, 11
    % 10 -> 26
    rotate_left(10, 10) = 0; rotate_left(10, 26) = 1;
    % 18 -> 27
    rotate_left(18, 18) = 0; rotate_left(18, 27) = 1;
    % 26 -> 28
    rotate_left(26, 26) = 0; rotate_left(26, 28) = 1;
    % 27 -> 20
    rotate_left(27, 27) = 0; rotate_left(27, 20) = 1;
    % 28 -> 12
    rotate_left(28, 28) = 0; rotate_left(28, 12) = 1;
    % 20 -> 11
    rotate_left(20, 20) = 0; rotate_left(20, 11) = 1;
    % 12 -> 10
    rotate_left(12, 12) = 0; rotate_left(12, 10) = 1;
    % 11 -> 18
    rotate_left(11, 11) = 0; rotate_left(11, 18) = 1;
end

state = [
%   1 2 3 4 5 6 7 8
    Z R Y O Z Y Y Z ... % 1-8
    Y B B B Y R R G ... % 9-16
    R B B B O R R G ... % 17-24
    O B B B R R R G ... % 25-32
    Z W W W Z W W Z ... % 33-40
];
prepare_rotate_left();
prepare_rotate_right();




rotate_left_2 = rotate_left*rotate_left*rotate_left;
print_state(state)
printf("==================================\n");

for i = 1:105
    state = (state*rotate_left_2)*rotate_right;

    if (state(10) == B) && (state(11) == B) && (state(12) == B) && (state(18) == B) && (state(19) == B)
        printf("i = %d\n", i);
        print_state(state)
        printf("==================================\n");
        pause
    end
end
% printf("==================================\n");
% print_state(state)

