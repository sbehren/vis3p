function result = Float2Str(number, precision)
    if nargin == 1
        precision = 12;
    end
    format_str = ['%.' num2str(precision) 'f'];
    result = sprintf(format_str, number);
end
