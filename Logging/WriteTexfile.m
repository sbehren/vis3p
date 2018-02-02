function WriteTexfile(setup, result)
    filename = setup.GetTexfileName;
    file = fopen(filename, 'w');
    
    WriteLatexTable(file, setup, result);
end

function WriteLatexTable(file, setup, result)
    WriteHeaderComment(file, setup);

    WriteConstraints(file, setup);
    WriteFeasiblePoint(file, setup);
    WriteProgramLabel(file);
    WriteOrder(file, setup);

    WriteOptimalValue(file, result);
    WriteDirection(file, result);
    WriteRhs(file, result);
    WriteFigureLabelAndNewline(file, setup);
end

function WriteHeaderComment(file, setup)
    hash = setup.GetFigureHash();
    figurename = setup.GetFigureName();

    fwriteln(file, ['% Results for figure ' figurename ' with SHA256 = ' hash ' follow in next line.']);
end

function WriteConstraints(file, setup)
    constraints = setup.GetConstraintStrings();
    for i = 1:length(constraints)
        con = ['$' constraints{i} '$'];
        WriteCell(file, con);
    end
end

function WriteFeasiblePoint(file, setup)
    for i = 1:setup.num_vars
        if setup.is_feasibility_variant
            q_str = 'n/a';
        else
            current_coordinate = setup.q(i);
            q_str = Float2ShortString(current_coordinate);
        end
        WriteCell(file, q_str);
    end
end

function WriteProgramLabel(file)
    WriteCell(file, 'insert label');
end

function WriteOrder(file, setup)
    order_str = num2str(setup.truncation_order);
    WriteCell(file, order_str);
end

function WriteOptimalValue(file, result)
    WriteFloatToCell(file, result.objective);
end

function WriteDirection(file, result)
    a = result.a;
    for i = 1:length(a)
        WriteFloatToCell(file, result.a(i));
    end
end

function WriteRhs(file, result)
    WriteFloatToCell(file, result.b);
end

function WriteFigureLabelAndNewline(file, setup)
    name = setup.name;
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
