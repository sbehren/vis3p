function filehash = GetFileHash(filename)
    syscall = ['sha256sum ' filename];
    [status, cmdout] = system(syscall);
    assert(status == 0, 'VI: Could not compute hash of figure.');
    
    split_info = strsplit(cmdout);
    filehash = split_info{1};
end
