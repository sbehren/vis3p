function result = Vec2Str(vec)
    result = '(';
    l = length(vec);
    for i = 1:l
        str_entry = num2str(vec(i));
        if i < l
            result = [result str_entry ','];
        end
    end
    result = [result str_entry ')'];
end
