global R = 100;
global G = 200;
global O = 300;
global B = 400;
global W = 500;
global Y = 600;
global Z = 700;

function print_state(s)
    global R
    global G
    global O
    global B
    global W
    global Y
    global Z

    printing_matrix = zeros(9, 12);
    printing_matrix = [
         Z  Z  Z  1  2  3  Z  Z  Z  Z  Z  Z
         Z  Z  Z  8  W  4  Z  Z  Z  Z  Z  Z
         Z  Z  Z  7  6  5  Z  Z  Z  Z  Z  Z
         9 10 11 17 18 19 33 34 35 41 42 43
        16  R 12 24  B 20 40  O 36 48  G 44
        15 14 13 23 22 21 39 38 37 47 46 45
         Z  Z  Z 25 26 27  Z  Z  Z  Z  Z  Z
         Z  Z  Z 32  Y 28  Z  Z  Z  Z  Z  Z
         Z  Z  Z 31 30 29  Z  Z  Z  Z  Z  Z
    ];

    for row = 1:9
        for col = 1:12
            s1 = printing_matrix(row, col);
            if (s1 >= R) && (s1 <= Z)
                s2 = s1;
            else
                s2 = s(s1);
            end

            switch s2
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
        end
        printf("\n");
    end
    printf("===================================\n")
end

function dump_state(s)
    global R
    global G
    global O
    global B
    global W
    global Y
    global Z
    for i = 1:48
        switch s(i)
            case R
                printf("R");
            case G
                printf("G");
            case O
                printf("O");
            case B
                printf("B");
            case W
                printf("W");
            case Y
                printf("Y");
            case Z
                printf(" ");
            otherwise
                printf("\n\n\nXXXXXXXXXXX\n\n\n");
        end
    end
    printf("\n");
end

function new_state = direct_rotate(s, inner_orbit, outer_orbit)
    new_state = s;
    printf("inner rotation:\n");
    for i = 1:8
        from = inner_orbit(i);
        to_index = i + 2;
        if to_index > 8
            to_index = to_index - 8;
        end
        to = inner_orbit(to_index);
        new_state(to) = s(from);
        printf("new_state(%d) = state(%d)\n", to, from);
    end
    printf("outer rotation:\n");
    for i = 1:12
        from = outer_orbit(i);
        to_index = i + 3;
        if to_index > 12
            to_index = to_index - 12;
        end
        to = outer_orbit(to_index);
        new_state(to) = s(from);
        printf("new_state(%d) = state(%d)\n", to, from);
    end
end

function rotation_matrix_to_direct_mapping(rotation_matrix)
    for from = 1:48
        for to = 1:48
            if (from != to) && (rotation_matrix(from, to) == 1)
                printf("new_state(%d) = state(%d)\n", to, from);
            end
        end
    end
end


function rotation_matrix = prepare_rotate_matrix(inner_orbit, outer_orbit)
    rotation_matrix = eye(48, 48);
    % printf("Inner orbit\n");
    for i = 1:8
        from = inner_orbit(i);
        to = i + 2;
        if to > 8
            to = to - 8;
        end
        to = inner_orbit(to);
        % printf("%2d -> %2d\n", from, to);
        rotation_matrix(from, from) = 0;    rotation_matrix(from, to) = 1;
    end
    % printf("Outer orbit\n");
    for i = 1:12
        from = outer_orbit(i);
        to = i + 3;
        if to > 12
            to = to - 12;
        end
        to = outer_orbit(to);
        % printf("%2d -> %2d\n", from, to);
        rotation_matrix(from, from) = 0;    rotation_matrix(from, to) = 1;
    end
    return
end

white_inner_orbit  = [ 1  2  3  4  5  6  7  8];
red_inner_orbit    = [ 9 10 11 12 13 14 15 16];
blue_inner_orbit   = [17 18 19 20 21 22 23 24];
yellow_inner_orbit = [25 26 27 28 29 30 31 32];
orange_inner_orbit = [33 34 35 36 37 38 39 40];
green_inner_orbit  = [41 42 43 44 45 46 47 48];

white_outer_orbit  = [43 42 41 35 34 33 19 18 17 11 10  9];
red_outer_orbit    = [ 1  8  7 17 24 23 25 32 31 45 44 43];
blue_outer_orbit   = [ 7  6  5 33 40 39 27 26 25 13 12 11];
yellow_outer_orbit = [23 22 21 39 38 37 47 46 45 15 14 13];
orange_outer_orbit = [ 5  4  3 41 48 47 29 28 27 21 20 19];
green_outer_orbit  = [ 3  2  1  9 16 15 31 30 29 37 36 35];


white_clockwise_rotation_matrix  = prepare_rotate_matrix(white_inner_orbit,  white_outer_orbit);
red_clockwise_rotation_matrix    = prepare_rotate_matrix(red_inner_orbit,    red_outer_orbit);
blue_clockwise_rotation_matrix   = prepare_rotate_matrix(blue_inner_orbit,   blue_outer_orbit);
yellow_clockwise_rotation_matrix = prepare_rotate_matrix(yellow_inner_orbit, yellow_outer_orbit);
orange_clockwise_rotation_matrix = prepare_rotate_matrix(orange_inner_orbit, orange_outer_orbit);
green_clockwise_rotation_matrix  = prepare_rotate_matrix(green_inner_orbit,  green_outer_orbit);

white_half_rotation_matrix  = white_clockwise_rotation_matrix * white_clockwise_rotation_matrix;
red_half_rotation_matrix    = red_clockwise_rotation_matrix * red_clockwise_rotation_matrix;
blue_half_rotation_matrix   = blue_clockwise_rotation_matrix * blue_clockwise_rotation_matrix;
yellow_half_rotation_matrix = yellow_clockwise_rotation_matrix * yellow_clockwise_rotation_matrix;
orange_half_rotation_matrix = orange_clockwise_rotation_matrix * orange_clockwise_rotation_matrix;
green_half_rotation_matrix  = green_clockwise_rotation_matrix * green_clockwise_rotation_matrix;


white_anticlock_rotation_matrix  = white_half_rotation_matrix * white_clockwise_rotation_matrix;
red_anticlock_rotation_matrix    = red_half_rotation_matrix * red_clockwise_rotation_matrix;
blue_anticlock_rotation_matrix   = blue_half_rotation_matrix * blue_clockwise_rotation_matrix;
yellow_anticlock_rotation_matrix = yellow_half_rotation_matrix * yellow_clockwise_rotation_matrix;
orange_anticlock_rotation_matrix = orange_half_rotation_matrix * orange_clockwise_rotation_matrix;
green_anticlock_rotation_matrix  = green_half_rotation_matrix  * green_clockwise_rotation_matrix;

solved_state = [
%   1 2 3 4 5 6 7 8
    W W W W W W W W ... % 1-8
    R R R R R R R R ... % 9-16
    B B B B B B B B ... % 17-24
    Y Y Y Y Y Y Y Y ... % 25-32
    O O O O O O O O ... % 33-40
    G G G G G G G G ... % 41-48
];

state = solved_state;

print_state(state)

orange_white_shuffle = ...
orange_clockwise_rotation_matrix * white_anticlock_rotation_matrix * ...
orange_anticlock_rotation_matrix * white_clockwise_rotation_matrix * ...
blue_clockwise_rotation_matrix * white_clockwise_rotation_matrix * ...
blue_anticlock_rotation_matrix * white_anticlock_rotation_matrix;

white_orange_shuffle = ...
white_anticlock_rotation_matrix * orange_clockwise_rotation_matrix * ...
white_clockwise_rotation_matrix * orange_anticlock_rotation_matrix * ...
blue_anticlock_rotation_matrix * orange_anticlock_rotation_matrix * ...
blue_clockwise_rotation_matrix * orange_clockwise_rotation_matrix;
%-------------------------------------------------------------------------------

white_red_shuffle = ...
white_clockwise_rotation_matrix * red_anticlock_rotation_matrix * ...
white_anticlock_rotation_matrix * red_clockwise_rotation_matrix * ...
blue_clockwise_rotation_matrix * red_clockwise_rotation_matrix * ...
blue_anticlock_rotation_matrix * red_anticlock_rotation_matrix;

red_white_shuffle = ...
red_anticlock_rotation_matrix * white_clockwise_rotation_matrix * ...
red_clockwise_rotation_matrix * white_anticlock_rotation_matrix * ...
blue_anticlock_rotation_matrix * white_anticlock_rotation_matrix * ...
blue_clockwise_rotation_matrix * white_clockwise_rotation_matrix;
%-------------------------------------------------------------------------------

red_yellow_shuffle = ...
red_clockwise_rotation_matrix * yellow_anticlock_rotation_matrix * ...
red_anticlock_rotation_matrix * yellow_clockwise_rotation_matrix * ...
blue_clockwise_rotation_matrix * yellow_clockwise_rotation_matrix * ...
blue_anticlock_rotation_matrix * yellow_anticlock_rotation_matrix;

yellow_red_shuffle = ...
yellow_anticlock_rotation_matrix * red_clockwise_rotation_matrix * ...
yellow_clockwise_rotation_matrix * red_anticlock_rotation_matrix * ...
blue_anticlock_rotation_matrix * red_anticlock_rotation_matrix * ...
blue_clockwise_rotation_matrix * red_clockwise_rotation_matrix;
%-------------------------------------------------------------------------------

yellow_orange_shuffle = ...
yellow_clockwise_rotation_matrix * orange_anticlock_rotation_matrix * ...
yellow_anticlock_rotation_matrix * orange_clockwise_rotation_matrix * ...
blue_clockwise_rotation_matrix * orange_clockwise_rotation_matrix * ...
blue_anticlock_rotation_matrix * orange_anticlock_rotation_matrix;

orange_yellow_shuffle = ...
orange_anticlock_rotation_matrix * yellow_clockwise_rotation_matrix * ...
orange_clockwise_rotation_matrix * yellow_anticlock_rotation_matrix * ...
blue_anticlock_rotation_matrix * yellow_anticlock_rotation_matrix * ...
blue_clockwise_rotation_matrix * yellow_clockwise_rotation_matrix;
%-------------------------------------------------------------------------------


diamond_shuffle1 = ...
orange_white_shuffle * white_red_shuffle * ...
orange_white_shuffle * white_red_shuffle * ...
orange_white_shuffle * white_red_shuffle * ...
orange_white_shuffle * white_red_shuffle;

diamond_shuffle2 = ...
white_red_shuffle * red_yellow_shuffle * ...
white_red_shuffle * red_yellow_shuffle * ...
white_red_shuffle * red_yellow_shuffle * ...
white_red_shuffle * red_yellow_shuffle;


diamond_shuffle3 = ...
red_yellow_shuffle * yellow_orange_shuffle * ...
red_yellow_shuffle * yellow_orange_shuffle * ...
red_yellow_shuffle * yellow_orange_shuffle * ...
red_yellow_shuffle * yellow_orange_shuffle;


triple_shuffle1 = ...
red_yellow_shuffle * orange_white_shuffle * ...
red_yellow_shuffle * orange_white_shuffle * ...
red_yellow_shuffle * orange_white_shuffle;

triple_shuffle2 = ...
white_red_shuffle * yellow_orange_shuffle * ...
white_red_shuffle * yellow_orange_shuffle * ...
white_red_shuffle * yellow_orange_shuffle;

triple_shuffle3 = ...
yellow_orange_shuffle * white_orange_shuffle * ...
yellow_orange_shuffle * white_orange_shuffle * ...
yellow_orange_shuffle * white_orange_shuffle;

cross_diamond_shuffle = ...
red_yellow_shuffle * yellow_orange_shuffle * white_orange_shuffle * red_white_shuffle;

swap_shuffle = ...
red_yellow_shuffle * orange_yellow_shuffle * orange_yellow_shuffle;

circular_shuffle = red_clockwise_rotation_matrix * ...
                   yellow_clockwise_rotation_matrix * ...
                   blue_clockwise_rotation_matrix;% * ...
                   %white_clockwise_rotation_matrix;

print_state(state)
% print_state(state * diamond_shuffle2)
% for i = 1:1000
%     i
%     state = state * circular_shuffle;
%     if mod(i, 1) == 0
%         print_state(state)
%         pause
%     end
    
% end
red_white_conjugate = blue_anticlock_rotation_matrix * ...
                      red_clockwise_rotation_matrix *  ...
                      blue_clockwise_rotation_matrix * ...
                      red_anticlock_rotation_matrix;

state = state * white_red_shuffle;
state = state * red_white_shuffle;
state = state * yellow_red_shuffle;
state = state * red_yellow_shuffle;

state = state * white_red_shuffle;
state = state * red_white_shuffle;
state = state * yellow_red_shuffle;
state = state * red_yellow_shuffle;

state = state * white_red_shuffle;
state = state * red_white_shuffle;
state = state * yellow_red_shuffle;
state = state * red_yellow_shuffle;

print_state(state)

% for i = 1:6
%     state = state * red_white_conjugate;
%     print_state(state);
% end
