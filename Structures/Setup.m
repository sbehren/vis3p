classdef Setup < handle
    properties
        name;

        num_vars;
        vartable;
        constraints;
        truncation_order;
        q;

        is_feasibility_variant = false; % set objective = 0
        normal_is_fixed = false;        % a is fixed
        fixed_normal = [];

        fundamental_directions;

        sdp_solver = 'sdpt3';
    end

    methods
        function obj = Setup(num_vars, fundamental_directions)
            obj.num_vars = num_vars;
            obj.vartable = sym('x', [num_vars, 1]);
            obj.fundamental_directions = fundamental_directions;
        end

        function path = GetPath(obj)
            AssertGitIntegrity();
            git_revision = GetGitRevison();
            path = strcat(obj.name, '-', git_revision, '.eps');
        end
    end
end
