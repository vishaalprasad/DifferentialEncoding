% Run with stimuli as in Hsiao et al (2008)

args = sergent_args('plots', {'ls-bars'}, 'stats',{});

[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {}, args{:});
[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {'D1#T1'}, args{:});
[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {'D1#T2'}, args{:});
[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {'D2#T1'}, args{:}); %rezad
[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {'D2#T2'}, args{:});
[mSets, models, stats] = de_Simulator('sergent_1982', 'de', 'sergent', {'swapped'}, args{:});

%de_SimulatorHL(2, 'de', 'dff', {},          args{:});
%de_SimulatorHL(2, 'de', 'gd', {},          args{:});
