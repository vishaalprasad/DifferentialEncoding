function [train,test] = de_StimCreate(stimSet, taskType, opt)
%Input:
%  stimSet  : a string specifying which INPUT sets to train autoencoder on
%                de: (default) 10 "far", 5 "near", 5 "on" images
%
%  taskType : a string specifying which OUTPUT task to train on
%               categorical = compare on (1) to off (0)
%               coordinate = compare near (1) vs. far (0)
%
%  opt      : a vector of options; all listed will be applied
%
%OUTPUT: a data file with the following variables:
%
%  train.X    : matrix containing 20 vectors, each a unique hierarchical stimulus.
%  train.T    : target vectors for perceptron (labels, based on task)
%
%  test.*     : same as train object, but

    if (~exist('opt','var')),      opt      = {};     end;
    if (~iscell(opt)),             opt      = {opt};  end;

    switch(stimSet)
        case 'blob-dot'
            train = MakeBlobDot(taskType);

        case 'paired-squares'
            train = MakePairedSquares(taskType);

        case 'plus-minus'
            train = MakePlusMinus(taskType);

        otherwise
            error('Invalid stimulus type. Choose one from: {''blob-dot'', ''paired-squares'', ''plus-minus''}');
    end;


    % Now say that test data is the same as training data.
    test = train;


function train = MakeBlobDot(taskType)
    % first, set some variables

    % Create the input images.
    train.nInput = [68 50];
    train.X = zeros(prod(train.nInput), 0);
    train.XLAB = {}; % blob-dot has 20 stimuli: 10 far/off, 5 near/off, 5 near/on
    train.TLAB = {};
    heights = [];

    % first, 10 "far" images
    distances = [10, 12];
    for ii=1:5
        for ij=1:length(distances)
            img = blob_stimuli(distances(ij), 3, ii);
            train.X(:, end+1) = reshape(img, prod(train.nInput), 1);
            train.XLAB{end+1} = sprintf('%dpx from %d%c', distances(ij), (ii-1)* 72, char(176));
            heights = [heights, distances(ij)];
        end
    end

    % now, 10 "close" images (5 on, 5 off)
    distances = [0, 4];
    for ii=1:5
        for ij=1:length(distances)
            img = blob_stimuli(distances(ij), 3, ii);
            train.XLAB{end+1} = sprintf('%dpx from %d%c', distances(ij), (ii-1)* 72, char(176));
            train.X(:, end+1) = reshape(img, prod(train.nInput), 1);
            heights = [heights, distances(ij)];
        end
    end

    % Create the output vectors.
    for ii = 1:20
        switch (taskType)
            case 'categorical'
                train.T = heights > 0;
                if train.T(ii) == 1
                    train.TLAB{ii} = 'on';
                else
                    train.TLAB{ii} = 'off';
                end
            case 'coordinate',
                train.T = abs(heights) / max(abs(heights));
                if train.T(ii) < 0.5
                    train.TLAB{ii} = 'near';
                else
                    train.TLAB{ii} = 'far';
                end
            otherwise, error('Unknown taskType: %s', taskType);
        end
    end


function train = MakePairedSquares(taskType)
%

    % first, set some variables
    distances = [2 3 4 5];

    train.nInput = [34 25];
    train.X = zeros(prod(train.nInput), 0);
    train.XLAB = {}; % paired squares has 16 stimuli: 4 distances left side x 4 distances right
    train.TLAB = {};

    left_distances = []; % to be used when assigning labels
    right_distances = [];

    % Create the 16 images
    for ii=1:length(distances) % left side: distance b/n squares ranges [2, 5]
        for ij = 1:length(distances) % right side: distance b/n square ranges [2, 5]
            img = paired_squares_stimuli(distances(ii), distances(ij), 0);
            train.X(:, end+1) = reshape(img, prod(train.nInput), 1);
            train.XLAB{end+1} = sprintf('(Dist) Left: %dpx ; Right: %dpx', distances(ii), distances (ij));
            left_distances = [left_distances, distances(ii)];
            right_distances = [right_distances, distances(ij)];
        end
    end
    test = train;

    % Create the output vectors.
    switch (taskType)
        case 'coordinate',
            train.T = (left_distances == right_distances); % same distance or no?
            for ii=1:16
                if train.T(ii) == 1
                    train.TLAB{ii} = 'same';
                else
                    train.TLAB{ii} = 'different';
                end
            end
        otherwise, error('Unknown taskType: %s. paired-squares only takes coordinate task type.', taskType);
    end


function train = MakePlusMinus(taskType)
%

    % first, set some variables

    % Create the input images.
    train.nInput = [34 25];
    train.X = zeros(prod(train.nInput), 0);
    train.XLAB = cell(16, 1); % blob-dot has 20 stimuli: 10 far/off, 5 near/off, 5 near/on
    train.TLAB = cell(16, 1);
    dist = []; % array of distances
    plus_on_right = []; % array of if plus is on right

    distances = [2 3 4 5 6 7 8 9];

    for ii=1:length(distances)
        for ij= -1 : 2 : 1  %is -1 or 1
            img = plus_minus_stimuli(distances(ii), ij);
            train.X(:, end+1) = reshape(img, prod(train.nInput), 1);
            if ij == -1, str = 'left'; else str = 'right'; end
            train.XLAB{end+1} = sprintf('Plus on %s, %dpx apart', str, distances(ii));
            dist = [dist, distances(ii)];
            plus_on_right = [plus_on_right, ij];
        end
    end

    test = train;

    % Create the output vectors.
    switch (taskType)
        case 'categorical'
            train.T = (plus_on_right == 1);
            for ii = 1:16
                if train.T(ii) == 1
                    train.TLAB{ii} = 'right';
                else
                    train.TLAB{ii} = 'left';
                end
            end
        case 'coordinate',
            train.T = abs(dist) / max(abs(dist));
            for ii=1:16
                if train.T(ii) <= 0.6 % make cut between 5/9, 6/9, but to avoid precision error use 0.6
                    train.TLAB{ii} = 'near';
                else
                    train.TLAB{ii} = 'far';
                end
            end
        otherwise, error('Unknown taskType: %s', taskType);
    end

    % Now say that test data is the same as training data.


function image = paired_squares_stimuli(left_distance, right_distance, four_pixel)
% Takes three parameters: 2 are distances from quartile lines
% Last parameter: if four_pixel = 1, then the square will be 4 pixels. For all other values it will be 1 pixel
% If four_pixel = 1, valid range for distances is  [2, 4]. If four_pixel != 1, valid range is [2, 5]. Anything
% outside this range will have weird output.

    image_height = 34;
    image_width = 25;

    horizontal_midline = image_height/2;
    vertical_midline = ceil(image_width/2);

    left_quarterline = floor(image_width/4);
    right_quarterline = image_width - left_quarterline;

    image = ones(image_height, image_width);

    for ii = 2:image_height-1
        image(ii, vertical_midline) = 0;
    end


    image(horizontal_midline, left_quarterline-left_distance+1) = 0;
    image(horizontal_midline, left_quarterline+left_distance) = 0;
    image(horizontal_midline, right_quarterline+right_distance) = 0;
    image(horizontal_midline, right_quarterline-right_distance+1) = 0;

    if (four_pixel == 1)

        image(horizontal_midline, left_quarterline-left_distance) = 0;
        image(horizontal_midline+1, left_quarterline-left_distance) = 0;
        image(horizontal_midline+1, left_quarterline-left_distance+1) = 0;

        image(horizontal_midline+1, left_quarterline+left_distance) = 0;
        image(horizontal_midline, left_quarterline+left_distance+1) = 0;
        image(horizontal_midline+1, left_quarterline+left_distance+1) = 0;


        image(horizontal_midline, right_quarterline-right_distance) = 0;
        image(horizontal_midline+1, right_quarterline-right_distance) = 0;
        image(horizontal_midline+1, right_quarterline-right_distance+1) = 0;

        image(horizontal_midline+1, right_quarterline+right_distance) = 0;
        image(horizontal_midline, right_quarterline+right_distance+1) = 0;
        image(horizontal_midline+1, right_quarterline+right_distance+1) = 0;
    end


function rot_image = blob_stimuli(distance, dot_size, orientation)

    %orientation is the follow values:
    % 1 = blob on left
    % 2 = blob rotated 72 degrees
    % 3 = blob rotated 144 degrees
    % 4 = blob rotated 216 degrees
    % 5 = blob rotated 288 degrees

    center_of_blob = [34, 15]; %hardcoded
    image_height = 68;
    image_width = 50;


    image = ones(image_height, image_width);
    rot_image = ones(image_height, image_width);

    center_y = center_of_blob(1);
    center_x = center_of_blob(2);


    image(center_y, center_x+6) = 0;
    image(center_y, center_x-6) = 0;
    image(center_y+10, center_x) = 0;
    image(center_y-10, center_x) = 0;
    image(center_y-11, center_x) = 0;
    image(center_y-12, center_x-1) = 0;
    image(center_y-13, center_x-2) = 0;
    image(center_y-13, center_x-3) = 0;
    image(center_y-12, center_x-4) = 0;
    image(center_y-11, center_x-5) = 0;
    image(center_y-10, center_x-5) = 0;
    image(center_y-9, center_x-5) = 0;
    image(center_y-8, center_x-5) = 0;
    image(center_y-7, center_x-4) = 0;
    image(center_y-6, center_x-4) = 0;
    image(center_y-5, center_x-4) = 0;
    image(center_y-4, center_x-5) = 0;
    image(center_y-3, center_x-5) = 0;
    image(center_y-3, center_x-6) = 0;
    image(center_y-2, center_x-6) = 0;
    image(center_y-1, center_x-6) = 0;
    image(center_y+1, center_x-6) = 0;
    image(center_y+2, center_x-7) = 0;
    image(center_y+3, center_x-7) = 0;
    image(center_y+4, center_x-7) = 0;
    image(center_y+5, center_x-8) = 0;
    image(center_y+6, center_x-8) = 0;
    image(center_y+7, center_x-8) = 0;
    image(center_y+8, center_x-7) = 0;
    image(center_y+9, center_x-6) = 0;
    image(center_y+10, center_x-5) = 0;
    image(center_y+9, center_x-4) = 0;
    image(center_y+8, center_x-4) =0;
    image(center_y+8, center_x-3) = 0;
    image(center_y+7, center_x-3) = 0;
    image(center_y+6, center_x-2) = 0;
    image(center_y+7, center_x-1) = 0;
    image(center_y+8, center_x-1) = 0;
    image(center_y+9, center_x) = 0;
    image(center_y+10, center_x+1) = 0;
    image(center_y+11, center_x+1) = 0;
    image(center_y+12, center_x+1) = 0;
    image(center_y+13, center_x+2) = 0;
    image(center_y+13, center_x+2) = 0;
    image(center_y+13, center_x+2) = 0;
    image(center_y+14, center_x+2) = 0;
    image(center_y+14, center_x+3) = 0;
    image(center_y+15, center_x+3) = 0;
    image(center_y+15, center_x+3) = 0;
    image(center_y+14, center_x+4) = 0;
    image(center_y+13, center_x+5) = 0;
    image(center_y+12, center_x+5) = 0;
    image(center_y+11, center_x+5) = 0;
    image(center_y+10, center_x+5) = 0;
    image(center_y+9, center_x+4) = 0;
    image(center_y+8, center_x+4) = 0;
    image(center_y+7, center_x+5) = 0;
    image(center_y+6, center_x+5) = 0;
    image(center_y+5, center_x+5) = 0;
    image(center_y+4, center_x+5) = 0;
    image(center_y+3, center_x+6) = 0;
    image(center_y+2, center_x+6) = 0;
    image(center_y+2, center_x+5) = 0;
    image(center_y+1, center_x+5) = 0;
    image(center_y-1, center_x+6) = 0;
    image(center_y-2, center_x+7) = 0;
    image(center_y-3, center_x+7) = 0;
    image(center_y-4, center_x+8) = 0;
    image(center_y-5, center_x+9) = 0;
    image(center_y-5, center_x+9) = 0;
    image(center_y-6, center_x+9) = 0;
    image(center_y-7, center_x+9) = 0;
    image(center_y-8, center_x+8) = 0;
    image(center_y-8, center_x+7) = 0;
    image(center_y-7, center_x+6) = 0;
    image(center_y-7, center_x+5) = 0;
    image(center_y-7, center_x+4) = 0;
    image(center_y-7, center_x+3) = 0;
    image(center_y-8, center_x+2) = 0;
    image(center_y-9, center_x+1) = 0;

    switch orientation
        case 1 % at the left
            rot_image = image;

            % Now make the "dot"
            if (mod(dot_size, 2) == 1)
                right_bound = floor(dot_size/2);
                left_bound = -1 * right_bound;
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+1, center_x + distance + 6 + j) = 0;
                    end
                end

            else
                right_bound = dot_size/2;
                left_bound = -1 *(dot_size-1);
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+1, center_x + distance + 6 + j) = 0;
                    end
                end
            end


        case 2 % 72 degrees
            image = image * -1 + 1; % invert for rotation
            rotated = imrotate(image, 72);
            rot_image(:, :) = rotated(2:69, 11:60);
            rot_image = rot_image * -1 + 1; % invert again


            % Now make the "dot"
            center_y = 40; %hard-coded
            center_x = 33;
            if (mod(dot_size, 2) == 1)
                right_bound = floor(dot_size/2);
                left_bound = -1 * right_bound;
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i-distance, center_x+distance+j) = 0;
                    end
                end

            else
                right_bound = dot_size/2;
                left_bound = -1 *(dot_size-1);
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i-distance, center_x+distance+j) = 0;
                    end
                end
            end


        case 3  % 144 degrees
            image = image * -1 + 1;
            rot_image = imrotate(image, 144);
            rot_image = rot_image(4:71, 15:64);
            rot_image = rot_image * -1 + 1;
            center_y = 42;
            center_x = 31; % hard coded

            if (mod(dot_size, 2) == 1)
                right_bound = floor(dot_size/2);
                left_bound = -1 * right_bound;
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i-distance, center_x-distance+j) = 0;
                    end
                end

            else
                right_bound = dot_size/2;
                left_bound = -1 *(dot_size-1);
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i-distance, center_x-distance+j) = 0;
                    end
                end
            end

        case 4 % 216 degrees
            image = image * -1 + 1;
            rotated = imrotate(image, 216);
            rot_image(:, :) = rotated(14:81, 20:69);
            rot_image = rot_image * -1 + 1;

            center_y = 27;
            center_x = 25;

            if (mod(dot_size, 2) == 1)
                right_bound = floor(dot_size/2);
                left_bound = -1 * right_bound;
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+distance, center_x-distance+j) = 0;
                    end
                end

            else
                right_bound = dot_size/2;
                left_bound = -1 *(dot_size-1);
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+distance, center_x-distance+j) = 0;
                    end
                end
            end



        case 5 %288 degrees
            image = image * -1 + 1;
            rotated = imrotate(image, 288);
            rotated = rotated * -1 + 1;
            rot_image = rotated(1:68, 20:69);
            center_y = 32;
            center_x = 17;
            if (mod(dot_size, 2) == 1)
                right_bound = floor(dot_size/2);
                left_bound = -1 * right_bound;
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+distance, center_x+j) = 0;
                    end
                end

            else
                right_bound = dot_size/2;
                left_bound = -1 *(dot_size-1);
                for i=left_bound:right_bound
                    for j=left_bound:right_bound
                        rot_image(center_y+i+distance, center_x+j) = 0;
                    end
                end
            end

        otherwise
            error('Invalid Orientation Number. Enter a number 1-5.');
    end


function image = plus_minus_stimuli(distance, plus_on_right)
% distance = distance of CENTER of plus, minus from midpoint
% distance = 0 means that the plus and minus are overlaid on top of each other
% valid distance ranges from [2, 11]
% plus_on_right = 1 if you want the plus on the right, 0 if on the left

    image_height = 34;
    image_width = 25;

    image = ones(34, 25);

    horiz_midline = (image_height)/2;
    center = ceil(image_width/2);

    for i = -1:1
        image(horiz_midline, center+distance+i) = 0;
        image(horiz_midline, center-distance-i) = 0;

        if (plus_on_right == 1)
            image(horiz_midline+1, center+distance) = 0;
            image(horiz_midline-1, center+distance) = 0;
        else
            image(horiz_midline+1, center-distance) = 0;
            image(horiz_midline-1, center-distance) = 0;
        end

    end
