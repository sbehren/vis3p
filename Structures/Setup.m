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

        data_folder = 'data';
    end

    methods
        function obj = Setup(num_vars, fundamental_directions)
            obj.num_vars = num_vars;
            obj.vartable = sym('x', [num_vars, 1]);
            obj.fundamental_directions = fundamental_directions;
        end

        function name = GetFigureName(obj)
            name = obj.GetFilenameWithEnding('eps');
        end

        function name = GetLogfileName(obj)
            name = obj.GetFilenameWithEnding('log');
        end

        function prefix = GetFilenameWithEnding(obj, ending)
            prefix = [obj.data_folder '/' obj.name '.' ending];
        end
    end
end

