function result = Vec2Str(num_vec)
    str_cell = ConvertNumericalVectorToStrings(num_vec);

    str_concatenated = ConcatenateStrings(str_cell);

    result = PadWithBrackets(str_concatenated);
end

function str_cell = ConvertNumericalVectorToStrings(num_vec)
    len = length(num_vec);
    str_cell = cell(len, 1);
    for i = 1:len
        str_cell{i} = num2str(num_vec(i));
    end
end

function str_concatenated = ConcatenateStrings(str_cell)
    str_concatenated = strjoin(str_cell, ', ');
end

function result = PadWithBrackets(str)
    result = ['(' str ')'];
end
