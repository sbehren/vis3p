function Draw(obj)
    StartPlottingEngine();

    PlotConstraints(obj);
    PlotValidInequality(obj);

    PlotFeasiblePointIfRequired(obj);
    PlotAnnotationIfRequired(obj);

    SetLegends(obj);
    PrintToFile(obj);

    StopPlottingEngine();
end

function StartPlottingEngine()
    clf;
    colormap gray;
    hold on;
    pbaspect([1 1 1]);
end

function PlotConstraints(scenario)
    for constraint = scenario.constraints
        ContourPlotWrapper(constraint)
    end
end

function PlotValidInequality(scenario)
    disp('VI: Start plotting.')
    vartable = scenario.vartable;
    ContourPlotWrapper(scenario.GetLinearFunction(vartable));
end

function PlotFeasiblePointIfRequired(scenario)
    if ~ scenario.is_feasibility_variant
        plot(scenario.q(1), scenario.q(2),'kp', 'MarkerSize', 10);
    end
end

function PlotAnnotationIfRequired(scenario)
    if scenario.annotate_feasible_set
        latex_annotation = texlabel('S');   
        pos = scenario.annotation_position;
        text(pos(1), pos(2), latex_annotation, 'FontSize', 16);
    end
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

function SetLegends(scenario)
    constraints_str = scenario.GetPlottingStrings();
    valid_ineq_str = 'valid inequality $a^Tx \leq b$';

    if scenario.is_feasibility_variant
        legend_text = [constraints_str, {valid_ineq_str}];
    else
        q_str = [num2str(scenario.q(1)), ',', num2str(scenario.q(2))];
        feasible_point_str = ['feasible point $q=(', q_str, ')$'];
        legend_text = [constraints_str, {valid_ineq_str, feasible_point_str}];
    end

    style_config = {'Interpreter', 'latex', 'FontSize', 14};

    legend(legend_text, style_config{:});
    xlabel('$x_1$', style_config{:});
    ylabel('$x_2$', style_config{:});
end

function PrintToFile(scenario)
    eps_filename = scenario.GetFigureName();
    export_fig(eps_filename);
end
