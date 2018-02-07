function WriteTexfile(obj)
    filename = obj.GetTexfileName;
    file = fopen(filename, 'w');
    
    WriteLatexTable(file, obj);
end

function WriteLatexTable(file, scenario)
    WriteHeaderComment(file, scenario);

    WriteConstraints(file, scenario);
    WriteFeasiblePoint(file, scenario);
    WriteProgramLabel(file);
    WriteOrder(file, scenario);

    WriteOptimalValue(file, scenario);
    WriteDirection(file, scenario);
    WriteRhs(file, scenario);
    WriteFigureLabelAndNewline(file, scenario);
end

function WriteHeaderComment(file, scenario)
    hash = scenario.GetFigureHash();
    figurename = scenario.GetFigureName();

    fwriteln(file, ['% Results for figure ' figurename ' with SHA256 = ' hash ' follow in next line.']);
end

function WriteConstraints(file, scenario)
    constraints = scenario.GetConstraintStrings();
    for i = 1:length(constraints)
        con = ['$' constraints{i} '$'];
        WriteCell(file, con);
    end
end

function WriteFeasiblePoint(file, scenario)
    for i = 1:scenario.num_vars
        if scenario.is_feasibility_variant
            q_str = 'n/a';
        else
            current_coordinate = scenario.q(i);
            q_str = Float2ShortString(current_coordinate);
        end
        WriteCell(file, q_str);
    end
end

function WriteProgramLabel(file)
    WriteCell(file, 'insert label');
end

function WriteOrder(file, scenario)
    order_str = num2str(scenario.truncation_order);
    WriteCell(file, order_str);
end

function WriteOptimalValue(file, scenario)
    WriteFloatToCell(file, scenario.objective);
end

function WriteDirection(file, scenario)
    a = scenario.a;
    for i = 1:length(a)
        WriteFloatToCell(file, scenario.a(i));
    end
end

function WriteRhs(file, scenario)
    WriteFloatToCell(file, scenario.b);
end

function WriteFigureLabelAndNewline(file, scenario)
    name = scenario.name;
    label = ['\ref{fig:' name '} \\'];
    fwriteln(file, label);
end

function WriteFloatToCell(file, number)
    WriteCell(file, Float2ShortString(number));
end
function WriteCell(file, str)
    fwritestr(file, [str ' & ']);
end

function result = Float2ShortString(number)
    result = Float2Str(number, 2);
end
