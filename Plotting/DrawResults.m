function DrawResults(setup, result)
    StartPlottingEngine();

    PlotConstraints(setup);
    PlotValidInequality(result);

    
    if ~ setup.is_feasibility_variant
        PlotFeasiblePoint(setup);
    end

    SetLegends(setup);

    path = setup.GetPath();
    export_fig(path);
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

function PlotValidInequality(result)
    disp('VI: Start plotting.')
    ContourPlotWrapper(result.linear_function);
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
    constraints_str = GetConstraintStrings(setup.constraints);
    valid_ineq_str = 'valid inequality $a^Tx \leq b$';

    if setup.is_feasibility_variant
        legend_text = [constraints_str, {valid_ineq_str}];
    else
        q_str = [num2str(setup.q(1)), ',', num2str(setup.q(2))];
        feasible_point_str = ['feasible point $q=(', q_str, ')$'];
        legend_text = [constraints_str, {valid_ineq_str, feasible_point_str}];
    end

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
