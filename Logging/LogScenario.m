function LogScenario(setup, result)
    setup.SetFigureHash();
    WriteLogfile(setup, result);
    WriteTexfile(setup, result);
end
