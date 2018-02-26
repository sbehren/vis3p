classdef LinearInequality < handle
    properties
        a = NaN;
        b = NaN;
        objective = Inf;
        solved = false;
        numerical_errors = NaN;
    end
    methods
        function linear_function = GetLinearFunction(obj, vartable)
            linear_function = obj.b - sum(obj.a .* vartable);
        end
    end
end
