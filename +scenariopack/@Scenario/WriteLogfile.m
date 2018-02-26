function WriteLogfile(obj)
    filename = obj.GetLogfileName;
    file = fopen(filename, 'w');

    WriteTimeStamp(file);
    WriteGitStatus(file);
    WriteSolutionTime(file, obj);
    WriteFigureInfo(file, obj);

    WriteSetupInfo(file, obj);
    WriteSolutionInfo(file, obj);
end

function WriteTimeStamp(file)
    time = datestr(now, 'yyyy-mm-dd_hh-MM-SS');
    info = ['Creation: ' time];
    fwriteln(file, info);
end

function WriteGitStatus(file)
    git_status = GetGitStatus();
    fwriteln(file, git_status);

    git_revision = GetGitRevison();
    revision_info = ['Git revision: ' git_revision];
    fwriteln(file, revision_info);
end

function git_status = GetGitStatus()
    changed_files_present = CheckChangesInGit();
    if changed_files_present 
        git_status = 'WARNING: Uncommitted changes.';
    else
        git_status = 'Directory clean, no uncommitted changes present.';
    end
    git_status = ['Git status: ' git_status];
end

function WriteSolutionInfo(file, scenario)
    WriteNumericalVector(file, scenario.a, 'a');
    WriteNumericalScalar(file, scenario.b, 'b');
    WriteNumericalScalar(file, scenario.objective, 'Objective value');
end

function WriteSetupInfo(file, scenario)
    WriteConstraints(file, scenario);
    WriteTruncationOrder(file, scenario);
    WriteFeasiblePoint(file, scenario);
end

function WriteTruncationOrder(file, scenario)
    truncation_str = ['Truncation order k = ' num2str(scenario.truncation_order)];
    fwriteln(file, truncation_str);
end

function WriteFeasiblePoint(file, scenario)
    if isempty(scenario.q)
        fwriteln(file, 'Feasible point: (no feasible point specified)');
    else
        WriteNumericalVector(file, scenario.q, 'Feasible point q');
    end
end

function WriteConstraints(file, scenario)
    con = scenario.GetConstraintStrings();
    len = length(con);
    for i = 1:len
        con_name = ['h(' num2str(i) ')'];
        con_formula = con{i};
        con_str = [con_name ' = ' con_formula];
        fwriteln(file, con_str);
    end
end

function WriteSolutionTime(file, scenario)
    solving_time_str = ['Secondes elapsed in solution process = ' Float2Str(scenario.solving_time)];
    fwriteln(file, solving_time_str);
end

function WriteFigureInfo(file, scenario)
    filename = scenario.GetFigureName();
    info_filename = ['Filename of figure: ' filename];
    fwriteln(file, info_filename);

    hash = scenario.GetFigureHash();
    hash_info = ['SHA-256 value of figure: ' hash];
    fwriteln(file, hash_info);
end

function WriteNumericalScalar(file, value, description)
    output_str = [description ' = ' Float2Str(value)];
    fwriteln(file, output_str);
end

function WriteNumericalVector(file, vec, description)
    for i = 1:length(vec)
        rolled_out_desc = [description '(' num2str(i) ')'];
        value = vec(i);
        WriteNumericalScalar(file, value, rolled_out_desc);
    end
end
