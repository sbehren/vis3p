classdef ValidInequality < handle
    properties
        a;
        b;
        objective;
        solved;
        numerical_errors;
        linear_function;
    end
    methods
        function InitUndefined(obj)
            obj.a = NaN;
            obj.b = NaN;
            obj.objective = Inf;
            obj.solved = false;
            obj.numerical_errors = true;
            obj.linear_function = NaN;

        end
        function InitLinearFunction(obj, vartable)
            obj.linear_function = obj.b - sum(obj.a .* vartable);
        end
    end
end

