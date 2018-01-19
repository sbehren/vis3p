function CheckGitIntegrity()
    [changed_files_present, ~] = system('git diff --exit-code');
    %TODO
    %assert(~ changed_files_present);
end
