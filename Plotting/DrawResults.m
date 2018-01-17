function DrawResults(setup, valid_ineqs)
    StartPlottingEngine();

    PlotConstraints(setup);
    PlotValidInequality(valid_ineqs);
    PlotFeasiblePoint(setup);

    SetLegends(setup);

    export_fig('myfig.eps');
    StopPlottingEngine();
end

function StartPlottingEngine()
    clf;
    colormap gray;
    hold on;
    pbaspect([1 1 1]);
end

function PlotConstraints(setup)
    for constraint = setup.constraints
        ContourPlotWrapper(constraint)
    end
end

function PlotValidInequality(valid_ineqs)
    disp('VI: Start plotting.')
    for idx = 1:length(valid_ineqs)
        valid_ineq = valid_ineqs{idx};
        if valid_ineq ~= 0
            ContourPlotWrapper(valid_ineq.linear_function);
        end
    end
end

function PlotFeasiblePoint(setup)
    plot(setup.q(1), setup.q(2),'kp', 'MarkerSize', 10);
end

function ContourPlotWrapper(f)
    style_index = GetColorOffset();
    
    linestyles = {'-', '-.', ':'};
    current_linestyle = linestyles{style_index + 1};

    fcontour(f, [-1.5, 1.5], 'LevelList', 0, 'LineWidth', 1.5', 'LineStyle', current_linestyle, 'LineColor', 'k');
end

function result = GetColorOffset()
    persistent style_index;
    period = 3;
    if isempty(style_index) || style_index == period
        style_index = 0;
    end
    result = style_index;
    style_index = style_index + 1;
end

function StopPlottingEngine()
    hold off;
end

function SetLegends(setup)
    q_str = [num2str(setup.q(1)), ',', num2str(setup.q(2))];
    constraints_str = GetConstraintStrings(setup.constraints);
    valid_ineq_str = 'valid inequality $a^Tx \leq b$';
    feasible_point_str = ['feasible point $q=(', q_str, ')$'];
    legend_text = [constraints_str, {valid_ineq_str, feasible_point_str}];

    style_config = {'Interpreter', 'latex', 'FontSize', 14};

    legend(legend_text, style_config{:});
    xlabel('$x_1$', style_config{:});
    ylabel('$x_2$', style_config{:});
end

function result = GetConstraintStrings(constraints)
    result = cell(1, length(constraints));
    for i = 1:length(constraints)
        constraint = constraints(i);
        result{i} = ConvertToLatex(constraint, i);
    end
end

function result = ConvertToLatex(sym_expr, index)
    raw = char(sym_expr);
    not_padded = strrep(raw, 'x', 'x_');
    result = ['$g_', num2str(index), '=', not_padded, '$'];
end
