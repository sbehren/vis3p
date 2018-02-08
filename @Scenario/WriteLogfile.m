function WriteLogfile(obj)
    filename = obj.GetLogfileName;
    file = fopen(filename, 'w');

    WriteTimeStamp(file);
    WriteGitStatus(file);

    WriteFigureInfo(file, obj);
    WriteSolutionInfo(file, obj)
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

function WriteFigureInfo(file, scenario)
    filename = scenario.GetFigureName();
    info_filename = ['Filename of figure: ' filename];
    fwriteln(file, info_filename);

    hash = scenario.GetFigureHash();
    hash_info = ['SHA-256 value of figure: ' hash];
    fwriteln(file, hash_info);
end

function WriteSolutionInfo(file, scenario)
    a = scenario.a;
    for i = 1:length(a)
        a_desc = ['a(' num2str(i) ')'];
        WriteNumericalValue(file, a(i), a_desc);
    end

    WriteNumericalValue(file, scenario.b, 'b');

    WriteNumericalValue(file, scenario.objective, 'Objective value');
end

function WriteNumericalValue(file, value, description)
    output_str = [description ' = ' Float2Str(value)];
    fwriteln(file, output_str);
end
