classdef Scenario < LinearInequality
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

        enable_hierarchy = false;

        fundamental_directions;

        sdp_solver = 'sedumi';

        data_folder = 'data';
        figure_hash = '';
    end

    methods
        function obj = Scenario(num_vars, fundamental_directions)
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

        function name = GetTexfileName(obj)
            name = obj.GetFilenameWithEnding('tex');
        end

        function prefix = GetFilenameWithEnding(obj, ending)
            prefix = [obj.data_folder '/' obj.name '.' ending];
        end

        function SetFigureHash(obj)
            filename = obj.GetFigureName();
            hash = GetFileHash(filename);
            obj.figure_hash = hash;
        end

        function hash = GetFigureHash(obj)
            hash = obj.figure_hash;
            assert(~ strcmp(hash, ''), 'VI: Error in getting hash of figure.');
        end

        function result = GetConstraintStrings(obj)
            cons = obj.constraints;
            result = cell(1, length(cons));
            for i = 1:length(cons)
                con = cons(i);
                result{i} = SymbolicConstraint2Latex(con);
            end
        end

        function result = GetPlottingStrings(obj)
            cons = obj.GetConstraintStrings();
            len = length(cons);
            result = cell(1, len);
            for i = 1:len
                constr = cons{i};
                result{i} = ['$h_', num2str(i), '=', constr, '$'];
            end
        end
    end
end
