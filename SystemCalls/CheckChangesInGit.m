function changed_files_present = CheckChangesInGit()
    [changed_files_present, ~] = system('git diff --exit-code');
end
