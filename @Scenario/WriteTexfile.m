function WriteTexfile(obj)
    file = OpenTexfile(obj);

    WriteHeaderComment(file, obj);
    WriteLatexTableCells(file, obj);
    WriteLineEnding(file);

    CloseTexfile(file)
end

function file = OpenTexfile(obj)
    filename = obj.GetTexfileName;
    file = fopen(filename, 'w');
end

function CloseTexfile(file)
    fclose(file);
end

function WriteHeaderComment(file, scenario)
    hash = scenario.GetFigureHash();
    figurename = scenario.GetFigureName();

    fwriteln(file, ['% Results for figure ' figurename ' with SHA256 = ' hash ' follow in next line.']);
end

function WriteLatexTableCells(file, scenario)
    cell_values = GetTableCells(scenario);
    WriteCellsToFile(file, cell_values);
end

function cell_values = GetTableCells(scenario)
    cell_values = {};

    cell_values{end + 1} = GetProgramRef();
    cell_values{end + 1} = GetConstraintRef();

    %cell_values          = AppendConstraintStr(cell_values, scenario);
    cell_values{end + 1} = GetOrder(scenario);
    cell_values          = AppendFeasiblePointStr(cell_values, scenario);


    cell_values{end + 1} = GetOptimalValue(scenario);
    cell_values          = AppendNormalVector(cell_values, scenario);
    cell_values{end + 1} = GetRhs(scenario);

    cell_values{end + 1} = GetFigureRef(scenario);
end

function result = GetProgramRef()
    result = 'insert ref';
end

function result = GetConstraintRef()
    result = 'insert ref';
end

function cell_values = AppendConstraintStr(cell_values, scenario)
    constraints = scenario.GetConstraintStrings();
    len = length(constraints);
    con_cell = cell(1, len);
    for i = 1:len
        con_cell{i} = ['$' constraints{i} '$'];
    end
    cell_values = [cell_values, con_cell];
end

function cell_values = AppendFeasiblePointStr(cell_values, scenario)
    num_cells = scenario.num_vars;
    q_strs = cell(1, num_cells);
    for i = 1:num_cells
        if scenario.is_feasibility_variant
            q_str = 'n/a';
        else
            current_coordinate = scenario.q(i);
            q_str = Float2ShortString(current_coordinate);
        end
        q_strs{i} = q_str;
    end
    cell_values = [cell_values, q_strs];
end

function order_str = GetOrder(scenario)
    order_str = num2str(scenario.truncation_order);
end

function result = GetOptimalValue(scenario)
    result = Float2ShortString(scenario.objective);
end

function cell_values = AppendNormalVector(cell_values, scenario)
    a = scenario.a;
    len = length(a);

    a_str = cell(1, len);
    for i = 1:len
        a_str{i} = Float2ShortString(scenario.a(i));
    end

    cell_values = [cell_values, a_str];
end

function result = GetRhs(scenario)
    result = Float2ShortString(scenario.b);
end

function result = GetFigureRef(scenario)
    name = scenario.name;
    result = ['\ref{fig:' name '}'];
end

function WriteCellsToFile(file, cell_values)
    cell_string = join(cell_values, ' & ');
    fwrite(file, cell_string);
end

function result = Float2ShortString(number)
    result = Float2Str(number, 2);
end

function WriteLineEnding(file)
    fwrite(file, ' \\');
end
