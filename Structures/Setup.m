classdef Setup
    properties
        min_order;
        max_order;
        num_vars;
        vartable;
        constraints;
        q;
        fundamental_directions;
        sdp_solver_options.solver = 'sedumi';
    end

    methods
        function obj = Setup(num_vars, fundamental_directions, constraints)
            obj.num_vars = num_vars;
            obj.vartable = sym('x', [num_vars, 1]);
            obj.fundamental_directions = fundamental_directions;
        end
    end
end
