function LogSetupAndResult(setup, result)
    setup.SetFigureHash();
    WriteLogfile(setup, result);
    WriteTexFile(setup, result);
end

function WriteTexFile(setup, result)
    filename = setup.GetTexfileName;
    file = fopen(filename, 'w');
    
    WriteHeader(file, setup);

    WriteConstraints(file, setup);
    WriteLabel(file);
    WriteOrder(file, setup);

    WriteOptimalValue(file, result);
    WriteDirection(file, result);
    WriteRhs(file, result);
    WriteFigure(file, setup);
end


function WriteHeader(file, setup)
    hash = setup.GetFigureHash();

    fwriteln(file, ['% Results for figure with SHA256 = ' hash ' follow in next line.']);

end

function WriteConstraints(file, setup)
    constraints = setup.GetConstraintStrings();
    for i = 1:length(constraints)
        con = ['$' constraints{i} '$'];
        WriteCell(file, con);
    end
end

function WriteLabel(file)
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

function WriteFigure(file, setup)
    name = setup.name;
    label = ['\ref{fig:' name '}'];
    fwriteln(file, label);
end

function WriteFloatToCell(file, number)
    WriteCell(file, Float2ShortString(number));
end
function WriteCell(file, str)
    fwritestr(file, [str ' & ']);
end

function result = Float2ShortString(number)
    result = Float2Str(number, 4);
end
