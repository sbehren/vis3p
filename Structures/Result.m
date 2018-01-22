classdef Result < handle
    properties
        a = NaN;
        b = NaN;
        objective = NaN;
        solved = NaN;
        numerical_errors = NaN;
        linear_function = NaN;
    end
    methods
        function InitLinearFunction(obj, vartable)
            obj.linear_function = obj.b - sum(obj.a .* vartable);
        end
    end
end
